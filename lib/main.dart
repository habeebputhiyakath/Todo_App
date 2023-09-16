import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/model/data_model.dart';
import 'bottom_bar.dart';
import 'theme/theme_manager.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // if (!Hive.isAdapterRegistered(TaskModelAdapter().typeId)) {
  //   Hive.registerAdapter(TaskModelAdapter());
  // }
  await Hive.openBox('Mybox');
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
