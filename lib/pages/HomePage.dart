import 'package:flutter/material.dart';
import 'package:todolist/pages/search%20bar.dart';

import 'drawer.dart';
import 'todolist.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isChecked = false;
  List todolist = [
    ['take a showe', false],
    ['do escersise', false],
    ['Meditate', false],
  ];
  void checkBoxchanged(bool? value, int index) {
    setState(() {
      todolist[index][1]=!todolist[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 45, 49, 116),
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
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
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
                height: 290,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 45, 49, 116),
                      Color.fromARGB(255, 1, 15, 54),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(left: 20, top: 10, child: AnimatedSearchBar()),
                    Positioned(
                        top: 65,
                        left: 20,
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                Colors.grey[600]!,
                                Colors.grey[500]!,
                                Colors.grey[200]!,
                                Colors.grey[600]!,
                                Colors.grey[300]!,
                                Colors.grey[200]!,
                              ],
                              tileMode: TileMode.clamp,
                            ).createShader(bounds);
                          },
                          child: Text(
                            'Hello..!\nAjmal',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        )),
                    _positionedContainer1(
                        200,
                        'asset/checked (2).png',
                        'Stop thinking start Doing..',
                        Color.fromARGB(255, 252, 172, 1),
                        210),
                    _positionedContainer1(
                        240,
                        'asset/like.png',
                        'Say no Excuses',
                        const Color.fromARGB(255, 80, 209, 84),
                        170),
                    _positionedContainer(90, 255),
                    _positionedContainer(140, 255),
                    _positionedContainer(190, 255),
                  ],
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
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "All Task's",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Colors.grey),
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
                );
              },
            ),
          )
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
}
