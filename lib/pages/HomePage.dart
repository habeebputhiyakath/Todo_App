import 'package:flutter/material.dart';
import 'package:todolist/pages/search%20bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: Column(
        children: [
          Stack(
  children: [
    Positioned.fill(
      child: Container(
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
      
    ),
   
   
   Container(
  width: double.infinity,
  height: 350,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(255, 5, 67, 201),
        Color.fromARGB(255, 11, 27, 172),
        Color.fromARGB(255, 5, 27, 87), 
      ],
    ),
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    ),
  ),
  child: Stack(
    children: [
       Positioned(
        left: 20,
        top: 45,
        child: AnimatedSearchBar()),
      Positioned(
        top: 100,
        left: 20,
        child: ShaderMask(
  shaderCallback: (Rect bounds) {
    return LinearGradient(
      colors: [Color.fromARGB(255, 13, 193, 199),Color.fromARGB(255, 67, 80, 253),Color.fromARGB(255, 13, 193, 199), Color.fromARGB(255, 240, 243, 243)],
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
)

      ),
      Positioned(
        left: 20,
        top: 230,
        child: 
      Container(
        width: 210,
        height: 25,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 252, 172, 1),
          borderRadius: BorderRadius.circular(20)
        ),
      )
      ),
      Positioned(
        left: 20,
        top: 270,
        child: 
      Container(
        width: 210,
        height: 25,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 80, 209, 84),
          borderRadius: BorderRadius.circular(20)
        ),
      )
      ),
    ], 
    
  ),
)
    
  ],
)

        ],
      ),
      
      );
    
  }
}
