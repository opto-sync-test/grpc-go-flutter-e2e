import 'dart:convert';

import 'package:grpc/grpc_web.dart';
import 'package:workmanager_web/execution.dart';

import 'background_sync.dart';
import 'gen/sync.pbgrpc.dart';

const optoSyncTaskName = 'opto-sync-multiplex-drain';

List<SyncLane> _lanes(Map<String, dynamic>? input) {
  final encoded = input?['lanes'] as String? ?? '[]';
  final values = jsonDecode(encoded) as List<dynamic>;
  return values
      .cast<Map<String, dynamic>>()
      .map(SyncLane.fromInput)
      .toList(growable: false);
}

/// Flutter-free dispatcher compiled into both a Web Worker and a Service
/// Worker. gRPC-Web cannot client-stream, so the same durable lanes are sent
/// concurrently as unary frames; native Flutter uses the bidirectional stream.
@pragma('vm:entry-point')
void callbackDispatcher() {
  WorkmanagerExecution.instance.executeTask((taskName, inputData) async {
    if (taskName != optoSyncTaskName) return false;
    final endpoint =
        inputData?['endpoint'] as String? ?? 'http://127.0.0.1:8080';
    final channel = GrpcWebClientChannel.xhr(Uri.parse(endpoint));
    final client = SyncServiceClient(channel);
    try {
      await Future.wait(
        _lanes(inputData).map(
          (lane) => client.merge(
            MergeRequest(
              baseJson: jsonEncode(lane.base),
              incomingJson: jsonEncode(lane.incoming),
            ),
          ),
        ),
      );
      return true;
    } finally {
      await channel.shutdown();
    }
  });
}
