import 'package:get_it/get_it.dart';
import 'package:minimal_flutter_template/services/my_service.dart';
import 'package:minimal_flutter_template/services/storage_service.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingletonAsync<StorageService>(StorageService().init);
  getIt.registerSingletonAsync<MyService>(MyService().init,
      dependsOn: [StorageService]);

  // すべての非同期初期化処理が完了するのを待つ
  await getIt.allReady();
}
