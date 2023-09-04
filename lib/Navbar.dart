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
  int _selectIndex = 0;

  static const List _widgetOptions = [
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
      backgroundColor: Colors.grey[100],
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 255, 102, 0),
        splashColor: Color.fromARGB(255, 240, 189, 48),
        onPressed: () {
          showDialog(
            context: context, 
            builder: (BuildContext context) {
              return AlertDialog(
                
                title: Text('Add Task'),
                content: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color:Color.fromARGB(255, 4, 18, 94)),
                      
                
                    )
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 74,
          child: Row(
            children: <Widget>[
              Row(
                children: [
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
                              ? Color.fromARGB(255, 4, 18, 94)
                              : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: _selectIndex == 0
                                ? Color.fromARGB(255, 4, 18, 94)
                                : Colors.grey,
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
                              ? Color.fromARGB(255, 4, 18, 94)
                              : Colors.grey,
                        ),
                        Text(
                          'Complete',
                          style: TextStyle(
                            color: _selectIndex == 1
                                ? Color.fromARGB(255, 4, 18, 94)
                                : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 39,
              ),
              Row(
                children: [
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
                              ? Color.fromARGB(255, 4, 18, 94)
                              : Colors.grey,
                        ),
                        Text(
                          'Incomplete',
                          style: TextStyle(
                            color: _selectIndex == 2
                                ? Color.fromARGB(255, 4, 18, 94)
                                : Colors.grey,
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
                              ? Color.fromARGB(255, 4, 18, 94)
                              : Colors.grey,
                        ),
                        Text(
                          'Chart',
                          style: TextStyle(
                            color: _selectIndex == 3
                                ? Color.fromARGB(255, 4, 18, 94)
                                : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
