import 'package:get_it/get_it.dart';
import 'package:minimal_flutter_template/services/api_client.dart';
import 'package:minimal_flutter_template/services/storage_service.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingletonAsync<StorageService>(StorageService().init);
  getIt.registerSingleton<ApiClient>(ApiClient());

  // すべての非同期初期化処理が完了するのを待つ
  await getIt.allReady();
}
