import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  // bool _isDarkMode =
  //     WidgetsBinding.instance.platformDispatcher.platformBrightness ==
  //         Brightness.dark;
  bool _isDarkMode = ThemeMode.system != ThemeMode.dark;
  bool get isDarkMode => _isDarkMode;
  late final SharedPreferences prefs;

  ThemeNotifier({required this.prefs}) {
    _loadTheme();
  }

  void _loadTheme() async {
    _isDarkMode =
        prefs.getBool('isDarkMode') ?? ThemeMode.system != ThemeMode.dark;

    notifyListeners();
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}
