import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:opto_sync_client/opto_sync_client.dart';

import '../lib/gen/sync.pbgrpc.dart';

Future<int> _availablePort() async {
  final socket = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
  final port = socket.port;
  await socket.close();
  return port;
}

Future<HealthResponse> _waitUntilReady(SyncServiceClient client) async {
  Object? lastError;
  for (var attempt = 0; attempt < 50; attempt++) {
    try {
      return await client.health(
        HealthRequest(),
        options: CallOptions(timeout: const Duration(milliseconds: 250)),
      );
    } catch (error) {
      lastError = error;
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
  }
  throw StateError('gRPC server did not become ready: $lastError');
}

void main() {
  test('Flutter crosses gRPC and merges through the pinned Go core', () async {
    final port = await _availablePort();
    final server = await Process.start(
      '../.build/grpc-server',
      const [],
      environment: {...Platform.environment, 'OPTO_SYNC_GRPC_PORT': '$port'},
    );
    final output = <String>[];
    final stdoutSubscription = server.stdout
        .transform(utf8.decoder)
        .listen(output.add);
    final stderrSubscription = server.stderr
        .transform(utf8.decoder)
        .listen(output.add);

    final channel = ClientChannel(
      '127.0.0.1',
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    try {
      final client = SyncServiceClient(channel);
      final health = await _waitUntilReady(client);
      expect(health.coreVersion, isNotEmpty);

      final clock = HybridLogicalClock(
        nodeId: 'flutter.e2e',
        now: () => 1700000000000,
      );
      final clientTimestamp = await clock.next();
      expect(parseHlc(clientTimestamp)?.nodeId, 'flutter.e2e');

      final response = await client.merge(
        MergeRequest(
          baseJson: jsonEncode({
            'id': 'doc-1',
            'profile': {'server': 'kept'},
            'items': [
              {'id': 'a', 'server': true},
            ],
          }),
          incomingJson: jsonEncode({
            'profile': {'client': 'kept', 'clientClock': clientTimestamp},
            'items': [
              {'id': 'a', 'client': true},
            ],
          }),
        ),
      );

      final merged = jsonDecode(response.mergedJson) as Map<String, dynamic>;
      final profile = merged['profile'] as Map<String, dynamic>;
      final item =
          (merged['items'] as List<dynamic>).single as Map<String, dynamic>;
      expect(profile['server'], 'kept');
      expect(profile['client'], 'kept');
      expect(profile['clientClock'], clientTimestamp);
      expect(item['server'], true);
      expect(item['client'], true);
      expect(response.coreVersion, health.coreVersion);
    } finally {
      await channel.shutdown();
      server.kill();
      await server.exitCode;
      await stdoutSubscription.cancel();
      await stderrSubscription.cancel();
    }
  });
}
