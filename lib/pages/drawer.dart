
import 'package:flutter/material.dart';
import 'package:todolist/pages/privacypage.dart';

class draWer extends StatelessWidget {
  const draWer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
         
          Container(height: 100,width: double.infinity,
          decoration:BoxDecoration(
                color: Color.fromARGB(255, 2, 120, 141),
                
                ),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text('Settings',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 25,),),
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
             Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>PrivacyPage()));
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



