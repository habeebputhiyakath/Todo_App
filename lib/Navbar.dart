import 'package:flutter/material.dart';

import 'package:todolist/pages/chart.dart';

import 'pages/Complete.dart';
import 'pages/HomePage.dart';
import 'pages/uncomplete.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});
  

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final dialogueController = TextEditingController();
  int _selectIndex = 0;

  static List _widgetOptions = [
    Homepage(),
    ComPleted(),
    UnComplete(),
    Chart(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Homepage();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 2, 120, 141),
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 74,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = Homepage();
                    _selectIndex = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: 30,
                      color: _selectIndex == 0
                          ? Colors.orange
                          : Colors.white,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: _selectIndex == 0
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
                    currentScreen = ComPleted();
                    _selectIndex = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.task_alt_outlined,
                      size: 30,
                      color: _selectIndex == 1
                          ?  Colors.orange
                          : Colors.white,
                    ),
                    Text(
                      'Complete',
                      style: TextStyle(
                        color: _selectIndex == 1
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
                    currentScreen = UnComplete();
                    ;
                    _selectIndex = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.rule,
                      size: 30,
                      color: _selectIndex == 2
                          ?  Colors.orange
                          : Colors.white,
                    ),
                    Text(
                      'Incomplete',
                      style: TextStyle(
                        color: _selectIndex == 2
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
                    currentScreen = Chart();
                    _selectIndex = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.leaderboard_outlined,
                      size: 30,
                      color: _selectIndex == 3
                          ?  Colors.orange
                          : Colors.white,
                    ),
                    Text(
                      'Chart',
                      style: TextStyle(
                        color: _selectIndex == 3
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
