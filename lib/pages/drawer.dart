
import 'package:flutter/material.dart';

class draWer extends StatelessWidget {
  const draWer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
         
          Container(height: 100,width: double.infinity,
          decoration:BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 45, 49, 116),
                      Color.fromARGB(255, 1, 15, 54),
                    ],
                  ),
                ),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text('Settings',style: TextStyle(color: const Color.fromARGB(255, 190, 188, 188),fontWeight: FontWeight.w600,fontSize: 25,),),
            ],
          ),
          ),
           ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Privacy Policy',style: TextStyle(color: const Color.fromARGB(255, 80, 79, 79),fontSize: 17),),
                Icon(Icons.lock,size: 20,color: Colors.grey,)
              ],
            ),
            onTap: () {
            
            },
          ),
          Divider(),
          ListTile(
            title: Text('Account Setting',style: TextStyle(color: const Color.fromARGB(255, 80, 79, 79),fontSize: 17),),
            onTap: () {
           
            },
          ),
          Divider(),
          ListTile(
            title: Text('Exit',style: TextStyle(color: const Color.fromARGB(255, 80, 79, 79),fontSize: 17),),
            onTap: () {
           
            },
          ),
          Divider(),
          ListTile(
            title: Text('Theme',style: TextStyle(color: const Color.fromARGB(255, 80, 79, 79),fontSize: 17),),
            onTap: () {
           
            },
          ),
          
          
        ],
      ),
    );
  }
}



