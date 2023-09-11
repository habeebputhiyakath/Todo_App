import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/bottom_bar.dart';
import 'theme/theme_manager.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context); 

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigation(),
      theme: themeManager.currentTheme, 
      darkTheme: ThemeData.dark(),
      themeMode: themeManager.currentThemeType == ThemeType.dark
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}
