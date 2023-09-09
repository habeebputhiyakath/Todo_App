import 'package:flutter/material.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 120, 141),
        title: Text('Account S'),
      ),
      body: Center(
        child: Text('Account_Setting_Page'),
      ),
    );
  }
}