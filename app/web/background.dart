import 'package:grpc_go_flutter_e2e/background_dispatcher.dart';
import 'package:workmanager_web/worker.dart';

void main() {
  WorkmanagerWebWorker.run(callbackDispatcher);
}
