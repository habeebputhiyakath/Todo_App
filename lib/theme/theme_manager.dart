import 'package:flutter/material.dart';
import 'package:todolist/screens/widget_pages/drawer.dart';

enum ThemeType { light, dark }

class ThemeManager extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();
  ThemeType _currentThemeType = ThemeType.light;

  ThemeData get currentTheme => _currentTheme;
  ThemeType get currentThemeType => _currentThemeType;

    Color get primaryColor =>
      _currentThemeType == ThemeType.dark ? Color.fromARGB(255, 0, 0, 0) : Color.fromARGB(255, 2, 120, 141);
    Color get accentColor =>
      _currentThemeType == ThemeType.dark ? Colors.blueGrey : Color.fromARGB(255, 255, 102, 0);
    Color get headingsColor =>
      _currentThemeType == ThemeType.dark ? Colors.grey[900]! : Colors.white;
    Color get pictureContainer =>
      _currentThemeType == ThemeType.dark ? Colors.grey[900]! : Color.fromARGB(255, 2, 155, 182);
    Color get deleteIcons =>
      _currentThemeType == ThemeType.dark ? Color.fromARGB(255, 36, 3, 180) : Color.fromARGB(255, 131, 1, 29);
    Color get searchIcons =>
      _currentThemeType == ThemeType.dark ? Color.fromARGB(255, 20, 20, 20)!  :Color.fromARGB(255, 2, 155, 182);
   
    Color get draWerColors =>
      _currentThemeType == ThemeType.dark ? Color.fromARGB(255, 24, 24, 24) : Color.fromARGB(255, 2, 120, 141);
   
    Color get smileyColors =>
      _currentThemeType == ThemeType.dark ? Color.fromARGB(255, 37, 37, 37) : Color.fromARGB(255, 2, 155, 182);
   

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
