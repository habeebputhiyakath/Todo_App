import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/screens/widget_pages/search%20bar.dart';
import '../theme/theme_manager.dart';
import 'widget_pages/drawer.dart';
import 'widget_pages/todolist.dart';

class Homepage extends StatefulWidget {
  Homepage({
    super.key,
  });
  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();
  final _myBox = Hive.box('Mybox');
  @override
  // void initState() {
  //   super.initState();
  //   _initializeTasks();
  // }
  // void _initializeTasks() {
  //   for (var i = 0; i < _myBox.length; i++) {
  //     final task = _myBox.getAt(i);
  //     todolist.add([task['taskName'], task['taskComplete']]);
  //   }
  // }
List todolist = [];
bool isChecked = false;
  final dialogueController = TextEditingController();
  void checkBoxchanged(bool? value, int index) {
  final task = _myBox.getAt(index);
  task['taskComplete'] = value ?? false;
  _myBox.putAt(index, task);
  setState(() {
    todolist[index][1] = value ?? false;
  });
}



  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeManager.primaryColor,
      ),
      endDrawer: draWer(),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                   boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.40),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: themeManager.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(left: 10, child: AnimatedSearchBar()),
                  ],
                ),
              ),
              Positioned(
                top: 92,
                left: 11,
                child: Container(
                  width: 390,
                  height: 110,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    boxShadow: [
                      shadow(5, 1)
                    ],
                      color: themeManager.pictureContainer,
                      borderRadius: BorderRadius.circular(70)),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            shadow(5,3)
                          ],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color.fromARGB(255, 185, 184, 184),
                            width: 2.0,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Hello',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: themeManager.headingsColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Task's",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Colors.grey),
                    ),
                    FloatingActionButton(
                      backgroundColor: themeManager.accentColor,
                      splashColor: Color.fromARGB(255, 240, 189, 48),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Add Task'),
                              content: TextFormField(
                                controller: dialogueController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 4, 18, 94)),
                                )),
                              ),
                              actions: <Widget>[
                                TextButton(
                                    child: Text('Add'),
                                    onPressed: () {
                                      addTask();
                                    }),
                                TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todolist.length,
              itemBuilder: (context, index) {
                return toDolist(
                  taskName: todolist[index][0],
                  tasComplete: todolist[index][1],
                  onChanged: (value) => checkBoxchanged(value, index),
                  deleteFunction: (context) {
                    deleteTask(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  BoxShadow shadow(double blurRadius,double spreadRadius) {
    return BoxShadow(
                            blurRadius: blurRadius,
                            spreadRadius: spreadRadius,
                            color: Color.fromARGB(255, 8, 8, 8).withOpacity(0.30),
                            offset: Offset(0, 7),
                            
                          );
  }

  Positioned _positionedContainer1(
      double top, String image1, String text1, Color color, double width) {
    return Positioned(
        left: 20,
        top: top,
        child: Container(
          width: width,
          height: 25,
          child: Row(
            children: [
              SizedBox(
                width: 3,
              ),
              Image.asset(
                image1,
                height: 20,
              ),
              Text(
                text1,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(20)),
        ));
  }

  Positioned _positionedContainer(double top, double left) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        height: 15,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.indigo,
        ),
      ),
    );
  }

  void addTask() {
    final taskName = dialogueController.text;
    final taskComplete = false;

    // _myBox.add({'taskName': taskName, 'taskComplete': taskComplete});

    dialogueController.clear();

    Navigator.of(context).pop();
    setState(() {
      todolist.add([taskName, taskComplete]);
    });
  }

  void deleteTask(int index) {
    // _myBox.deleteAt(index);
    setState(() {
      todolist.removeAt(index);
    });
  }
}

