import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/bottom_bar.dart';
import 'package:todolist/theme/theme_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoHome(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
      backgroundColor: themeManager.primaryColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 350),
            child:
                Center(child: Icon(Icons.note_add_outlined,size: 150,color: themeManager.searchIcons,)),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> gotoHome(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => BottomNavigation()));
  }
}
