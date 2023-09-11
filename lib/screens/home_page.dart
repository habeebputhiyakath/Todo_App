import 'package:flutter/material.dart';
import 'package:todolist/screens/widget_pages/search%20bar.dart';

import 'widget_pages/drawer.dart';
import 'widget_pages/todolist.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
  });
  
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
 draWer tfd=draWer();
  bool isChecked = false;
  List todolist = [];
  final dialogueController = TextEditingController();
  void checkBoxchanged(bool? value, int index) {
    setState(() {
      todolist[index][1] = !todolist[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 2, 120, 141),
      ),
      endDrawer: draWer(),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      spreadRadius: 10,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 2, 120, 141),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(left: 10, child: AnimatedSearchBar()),
                  ],
                ),
              ),
              Positioned(
                top: 100,
                left: 11,
                child: Container(
                  width: 390,
                  height: 110,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 3, 149, 175),
                      borderRadius: BorderRadius.circular(70)),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
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
                      SizedBox(width: 20,),
                      Text('Hello',style: TextStyle(fontSize: 20,color: Colors.white),)
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
                color: Colors.white,
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
                      backgroundColor: Color.fromARGB(255, 255, 102, 0),
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
    setState(() {
      todolist.add([dialogueController.text.trim(), false]);
      Navigator.of(context).pop();

    });
    
  }
  
  void deleteTask(int index) {
    setState(() {
      todolist.removeAt(index);
    });
  }
}
