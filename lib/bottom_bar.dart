import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todolist/screens/chart.dart';

import 'theme/theme_manager.dart';
import 'screens/completed_page.dart';
import 'screens/home_page.dart';
import 'screens/in_complete.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({super.key});
  

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectIndex = 0;
  
  static List widgetOptions = [
    const HomePage(),
    Completed(),
    const UnComplete(),
    const Chart(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();
  
  
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        color: themeManager.primaryColor,
        notchMargin: 10,
        child: SizedBox(
          height: 74,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = const HomePage();
                    selectIndex = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: 30,
                      color: selectIndex == 0
                          ? Colors.orange
                          : Colors.white,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: selectIndex == 0
                            ?  Colors.orange
                            : Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen =  Completed();
                    selectIndex = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.task_alt_outlined,
                      size: 30,
                      color: selectIndex == 1
                          ?  Colors.orange
                          :  Colors.white,
                    ),
                    Text(
                      'Complete',
                      style: TextStyle(
                        color: selectIndex == 1
                            ?  Colors.orange
                            : Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = const UnComplete();
                    selectIndex = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.rule,
                      size: 30,
                      color: selectIndex == 2
                          ?  Colors.orange
                          : Colors.white,
                    ),
                    Text(
                      'Incomplete',
                      style: TextStyle(
                        color: selectIndex == 2
                            ? Colors.orange
                            : Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = const Chart();
                    selectIndex = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.leaderboard_outlined,
                      size: 30,
                      color: selectIndex == 3
                          ?  Colors.orange
                          : Colors.white,
                    ),
                    Text(
                      'Chart',
                      style: TextStyle(
                        color: selectIndex == 3
                            ?  Colors.orange
                            : Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}
