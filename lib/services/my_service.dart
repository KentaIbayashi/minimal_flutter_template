import 'package:minimal_flutter_template/di_container.dart';
import 'package:minimal_flutter_template/services/storage_service.dart';

class MyService {
  late StorageService storageService;
  Future<MyService> init() async {
    print('Initializing MyService...');
    storageService = getIt.get<StorageService>();
    await Future.delayed(Duration(seconds: 1));
    print('MyService initialized!');

    return this;
  }

  void doSomething() {
    print('Doing something...');
  }
}
