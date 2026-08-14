import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:workmanager/workmanager.dart';

import 'background_dispatcher.dart';
import 'background_sync.dart';
import 'gen/sync.pbgrpc.dart';

const _host = String.fromEnvironment(
  'OPTO_SYNC_HOST',
  defaultValue: '127.0.0.1',
);
const _port = int.fromEnvironment('OPTO_SYNC_PORT', defaultValue: 50051);
const _webEndpoint = String.fromEnvironment(
  'OPTO_SYNC_WEB_ENDPOINT',
  defaultValue: 'http://127.0.0.1:8080',
);

List<SyncLane> _demoLanes() => const [
  SyncLane(
    lane: 'documents/doc-1',
    sequence: 1,
    base: {
      'id': 'doc-1',
      'profile': {'server': 'kept'},
    },
    incoming: {
      'profile': {'flutterBackground': 'mobile-or-desktop'},
    },
  ),
  SyncLane(
    lane: 'documents/doc-2',
    sequence: 1,
    base: {
      'id': 'doc-2',
      'profile': {'server': 'kept'},
    },
    incoming: {
      'profile': {'flutterBackground': 'second-multiplex-lane'},
    },
  ),
];

Future<void> _registerBackgroundScheduler(List<SyncLane> demoLanes) async {
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
    // Workmanager currently has no Windows backend. Keep the same durable lane
    // contract alive in the desktop process; a Windows service can call this
    // worker with the same serialized batch when app-closed delivery is needed.
    final channel = ClientChannel(
      _host,
      port: _port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    final worker = MultiplexBackgroundSyncWorker(SyncServiceClient(channel));
    worker
        .run(
          Stream<List<SyncLane>>.periodic(
            const Duration(minutes: 15),
            (_) => demoLanes,
          ),
        )
        .listen((_) {}, onError: (_) {});
    return;
  }

  await Workmanager().initialize(callbackDispatcher);
  final lanes = jsonEncode(demoLanes.map((lane) => lane.toInput()).toList());
  await Workmanager().registerPeriodicTask(
    'opto-sync-periodic-multiplex',
    optoSyncTaskName,
    frequency: const Duration(minutes: 15),
    constraints: Constraints(networkType: NetworkType.connected),
    inputData: {
      'host': _host,
      'port': _port,
      'endpoint': _webEndpoint,
      'lanes': lanes,
    },
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final demoLanes = _demoLanes();
  await _registerBackgroundScheduler(demoLanes);
  runApp(const OptoSyncRuntimeProbe());
}

class OptoSyncRuntimeProbe extends StatelessWidget {
  const OptoSyncRuntimeProbe({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
    home: Scaffold(
      body: Center(child: Text('OptoSync background worker registered')),
    ),
  );
}
