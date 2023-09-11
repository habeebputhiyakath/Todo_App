import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/screens/widget_pages/drawer_pages/aboutpage.dart';
import 'package:todolist/screens/widget_pages/drawer_pages/privacypage.dart';

import '../../theme/theme_manager.dart';

class draWer extends StatefulWidget {
  draWer({Key? key}) : super(key: key);

  get themeMode => null;

  @override
  State<draWer> createState() => _draWerState();
}

class _draWerState extends State<draWer> {
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Drawer(
      elevation: 5,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 2, 120, 141),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.lock,
                  size: 20,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 80, 79, 79),
                      fontSize: 17),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => PrivacyPage()));
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.manage_accounts,
                  size: 20,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Account Settings',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 80, 79, 79),
                      fontSize: 17),
                ),
              ],
            ),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.dark_mode_outlined,
                  size: 20,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Theme',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 80, 79, 79),
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            trailing: Switch(
              value: themeManager.currentThemeType == ThemeType.dark,
              onChanged: (newValue) {
                themeManager.toggleTheme();
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  size: 20,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'About',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 80, 79, 79),
                      fontSize: 17),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => AboutPage()));
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.exit_to_app,
                  size: 20,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Exit',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 80, 79, 79),
                      fontSize: 17),
                ),
              ],
            ),
            onTap: () {},
          ),
          Divider(),
        ],
      ),
    );
  }
}
