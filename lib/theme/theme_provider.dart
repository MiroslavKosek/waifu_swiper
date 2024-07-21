import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waifu_swiper/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themePrefKey = "theme_pref";
  ThemeData _themeData = lightMode;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    _saveTheme();
    notifyListeners();
  }

  bool get isDark => _themeData == darkMode;

  void toggleTheme() {
    themeData = _themeData == lightMode ? darkMode : lightMode;
  }

  void _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themePrefKey, isDark);
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themePrefKey) ?? false;
    _themeData = isDark ? darkMode : lightMode;
    notifyListeners();
  }
}