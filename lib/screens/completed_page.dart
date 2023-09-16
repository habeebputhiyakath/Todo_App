import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/screens/home_page.dart';

import '../theme/theme_manager.dart';

class ComPleted extends StatelessWidget {
 ComPleted({super.key}); 
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
   return Scaffold(
      body: Column(
        children: [
          Container(
                width: double.infinity,
                height: 315,
                decoration: BoxDecoration(
                  color: themeManager.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.40),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: Stack(
                  children: [
                    _completedIcons(110,70,Icons.sentiment_satisfied_rounded,180,themeManager.smileyColors),
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
                    color: themeManager.headingsColor,
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
              ),
              
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