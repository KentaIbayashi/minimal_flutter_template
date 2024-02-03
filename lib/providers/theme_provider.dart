import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_flutter_template/di_container.dart';
import 'package:minimal_flutter_template/services/storage_service.dart';

class ThemeNotifier extends Notifier<bool> {
  @override
  bool build() {
    _loadFromPrefs();
    return state;
  }

  _loadFromPrefs() {
    final prefs = getIt.get<StorageService>();
    final isDarkMode = prefs.getIsDarkMode();
    state = isDarkMode;
  }

  _saveToPrefs() async {
    final prefs = getIt.get<StorageService>();
    await prefs.saveIsDarkMode(state);
  }

  void toggle() async {
    state = !state;
    await _saveToPrefs();
  }
}

final themeNotifierProvider =
    NotifierProvider<ThemeNotifier, bool>(ThemeNotifier.new);
