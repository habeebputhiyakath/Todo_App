import 'package:flutter/material.dart';

class ComPleted extends StatelessWidget {
  const ComPleted({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Column(
        children: [
          Container(
                width: double.infinity,
                height: 350,
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
                    _completedIcons(110,70,Icons.sentiment_satisfied_rounded,180,Colors.indigo),
                    _completedIcons(110,70,Icons.star,40,Colors.amber[400]!),
                    _completedIcons(275,110,Icons.star,30,Colors.amber[400]!),
                    _completedIcons(125,220,Icons.star,30,Colors.amber[400]!),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Completed",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
                ),
              )
        ],
      )
    );
  }

  Positioned _completedIcons(double left,double top, IconData icon,double iconSize,Color color) {
    return Positioned(
                    left: left,
                    top: top,
                    child: Icon(icon,size: iconSize,color: color,));
  }
}