import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:workmanager/workmanager.dart';

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

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName != optoSyncTaskName) return false;
    final host = inputData?['host'] as String? ?? '127.0.0.1';
    final port = inputData?['port'] as int? ?? 50051;
    final channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    try {
      final worker = MultiplexBackgroundSyncWorker(SyncServiceClient(channel));
      await worker.drain(_lanes(inputData));
      return true;
    } finally {
      await channel.shutdown();
    }
  });
}
