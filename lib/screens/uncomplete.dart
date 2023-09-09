import 'package:flutter/material.dart';

class UnComplete extends StatelessWidget {
  const UnComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                 color: Color.fromARGB(255, 2, 120, 141),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Stack(
                  children: [
                    _completedIcons(110,70,Icons.sentiment_dissatisfied_rounded,180,Color.fromARGB(255, 3, 149, 175),),
                    _completedIcons(110,70,Icons.water_drop,40,Colors.cyan),
                    _completedIcons(275,110,Icons.water_drop,30,Colors.cyan),
                    _completedIcons(125,220,Icons.water_drop,30,Colors.cyan),
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
                      "Incompleted",
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