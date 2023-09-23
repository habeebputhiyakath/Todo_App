import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum ThemeType { light, dark }

class ThemeManager extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();
  ThemeType _currentThemeType = ThemeType.light;

  ThemeData get currentTheme => _currentTheme;
  ThemeType get currentThemeType => _currentThemeType;

  static const String themeBoxName = 'theme_box';
  static const String selectedThemeKey = 'selected_theme';

  Color get primaryColor => _currentThemeType == ThemeType.dark
      ? Color.fromARGB(255, 0, 0, 0)
      : Color.fromARGB(255, 1, 59, 70);
  Color get floatingButtonColor => _currentThemeType == ThemeType.dark
      ? Colors.blueGrey
      : Color.fromARGB(255, 255, 102, 0);
  Color get headingsColor =>
      _currentThemeType == ThemeType.dark ? Colors.grey[900]! : Color.fromARGB(255, 235, 235, 235);
  Color get pictureContainer => _currentThemeType == ThemeType.dark
      ? Colors.grey[900]!
      : Color.fromARGB(255, 1, 68, 80);
  Color get deleteIcons => _currentThemeType == ThemeType.dark
      ? Color.fromARGB(255, 151, 143, 144)
      : Color.fromARGB(255, 99, 90, 92);
  Color get searchIcons => _currentThemeType == ThemeType.dark
      ? Color.fromARGB(255, 20, 20, 20)
      : Color.fromARGB(255, 1, 68, 80);

  Color get draWerColors => _currentThemeType == ThemeType.dark
      ? Color.fromARGB(255, 24, 24, 24)
      : Color.fromARGB(255, 1, 59, 70);

  Color get smileyColors => _currentThemeType == ThemeType.dark
      ? Color.fromARGB(255, 37, 37, 37)
      : Color.fromARGB(255, 1, 91, 107);
  Color get completedPageColors => _currentThemeType == ThemeType.dark
      ? Color.fromARGB(255, 19, 18, 18)
      : Color.fromARGB(255, 223, 248, 236);
  Color get completedTaskColors => _currentThemeType == ThemeType.dark
      ? Color.fromARGB(255, 14, 43, 1)
      : Colors.green[100]!;
  Color get incompletedTaskColors => _currentThemeType == ThemeType.dark
      ? Color.fromARGB(255, 54, 1, 1)
      : Colors.red[100]!;

void toggleTheme() async {
  if (_currentThemeType == ThemeType.light) {
    _currentTheme = ThemeData.dark();
    _currentThemeType = ThemeType.dark;
  } else {
    _currentTheme = ThemeData.light();
    _currentThemeType = ThemeType.light;
  }
  final themeBox = await Hive.openBox(themeBoxName);
  themeBox.put(selectedThemeKey, _currentThemeType.toString());

  notifyListeners();
}
Future<void> initializeTheme() async {
  final themeBox = await Hive.openBox(themeBoxName);
  final selectedTheme = themeBox.get(selectedThemeKey);

  if (selectedTheme == null) {
    _currentThemeType = ThemeType.light;
  } else {
    _currentThemeType = ThemeType.values
        .firstWhere((type) => type.toString() == selectedTheme);
  }
  if (_currentThemeType == ThemeType.light) {
    _currentTheme = ThemeData.light();
  } else {
    _currentTheme = ThemeData.dark();
  }

  notifyListeners();
}

}
