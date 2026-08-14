import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:opto_sync_client/opto_sync_client.dart';

import '../lib/background_sync.dart';
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

  test(
    'background worker replays a multiplexed bidirectional stream after reconnect',
    () async {
      final port = await _availablePort();
      final channel = ClientChannel(
        '127.0.0.1',
        port: port,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
      final worker = MultiplexBackgroundSyncWorker(
        SyncServiceClient(channel),
        maxAttempts: 20,
        retryDelay: const Duration(milliseconds: 75),
        callTimeout: const Duration(milliseconds: 150),
      );
      final drain = worker.drain(const [
        SyncLane(
          lane: 'documents/doc-1',
          sequence: 1,
          base: {
            'id': 'doc-1',
            'profile': {'server': 'kept'},
          },
          incoming: {
            'profile': {'mobile': 'android-ios'},
          },
        ),
        SyncLane(
          lane: 'documents/doc-2',
          sequence: 7,
          base: {
            'id': 'doc-2',
            'profile': {'server': 'kept'},
          },
          incoming: {
            'profile': {'desktop': 'linux-macos-windows'},
          },
        ),
      ]);

      await Future<void>.delayed(const Duration(milliseconds: 400));
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

      try {
        await _waitUntilReady(SyncServiceClient(channel));
        final responses = await drain;
        expect(responses.map((response) => response.lane).toSet(), {
          'documents/doc-1',
          'documents/doc-2',
        });
        expect(responses.map((response) => response.sequence.toInt()).toSet(), {
          1,
          7,
        });
        final mobile =
            jsonDecode(
                  responses
                      .singleWhere(
                        (response) => response.lane.endsWith('doc-1'),
                      )
                      .mergedJson,
                )
                as Map<String, dynamic>;
        final desktop =
            jsonDecode(
                  responses
                      .singleWhere(
                        (response) => response.lane.endsWith('doc-2'),
                      )
                      .mergedJson,
                )
                as Map<String, dynamic>;
        expect(mobile['profile'], {'server': 'kept', 'mobile': 'android-ios'});
        expect(desktop['profile'], {
          'server': 'kept',
          'desktop': 'linux-macos-windows',
        });
      } finally {
        await channel.shutdown();
        server.kill();
        await server.exitCode;
        await stdoutSubscription.cancel();
        await stderrSubscription.cancel();
      }
    },
  );
}
