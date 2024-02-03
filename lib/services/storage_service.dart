import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // hiveの初期化処理を行う
  late SharedPreferences prefs;

  Future<StorageService> init() async {
    print('Initializing StorageService...');
    prefs = await SharedPreferences.getInstance();

    //await Future.delayed(Duration(seconds: 1));
    print('StorageService initialized!');

    return this;
  }

  Future<void> saveIsDarkMode(bool isDarkMode) async {
    await prefs.setBool(StorageKey.isDarkMode.name, isDarkMode);
  }

  bool getIsDarkMode() {
    final bool? isDarkMode = prefs.getBool(StorageKey.isDarkMode.name);
    return isDarkMode ?? false;
  }
}

enum StorageKey {
  isDarkMode,
}
