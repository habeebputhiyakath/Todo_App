import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_manager.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
   return Scaffold(
    appBar: AppBar(
      backgroundColor: themeManager.primaryColor,
      title: Text('Chart'),
    ),
      body: Center(
        child: Text('chart'),
      ),
    );
  }
}