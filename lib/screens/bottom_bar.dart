import 'package:flutter/material.dart';

import 'package:todolist/screens/chart.dart';

import 'completed_page.dart';
import 'home_page.dart';
import 'uncomplete.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({super.key});
  

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectIndex = 0;

  static List widgetOptions = [
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
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 2, 120, 141),
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
                    currentScreen = ComPleted();
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
                    currentScreen = UnComplete();
                    ;
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
                    currentScreen = Chart();
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
