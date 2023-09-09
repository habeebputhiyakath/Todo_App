import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 120, 141),
        title: Text('About'),
      ),
      body: Center(
        child: Text('About_Page'),
      )
    );
  }
}