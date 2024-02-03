import 'package:minimal_flutter_template/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late SharedPreferences prefs;

  Future<StorageService> init() async {
    prefs = await SharedPreferences.getInstance();
    logger.d('StorageService initialized');
    // デモ用にローディングを長く見せるためにわざと遅延させる
    await Future.delayed(const Duration(seconds: 1));

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
