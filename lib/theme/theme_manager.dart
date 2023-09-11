import 'package:flutter/material.dart';

enum ThemeType { light, dark }

class ThemeManager extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();
  ThemeType _currentThemeType = ThemeType.light;

  ThemeData get currentTheme => _currentTheme;
  ThemeType get currentThemeType => _currentThemeType;

  void toggleTheme() {
    if (_currentThemeType == ThemeType.light) {
      _currentTheme = ThemeData.dark();
      _currentThemeType = ThemeType.dark;
    } else {
      _currentTheme = ThemeData.light();
      _currentThemeType = ThemeType.light;
    }
    notifyListeners();
  }
}
