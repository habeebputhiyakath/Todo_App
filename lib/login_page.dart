import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/bottom_bar.dart';
import 'package:todolist/splash.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  static const String SAVE_KEY_NAME = "User_name";
  final _formKey = GlobalKey<FormState>();

  void checkLoggedInUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storedUsername = sharedPreferences.getString(SAVE_KEY_NAME);

    if (storedUsername != null && storedUsername.isNotEmpty) {
      navigateToBottomNavigation(context);
    }
  }

  @override
  void initState() {
    setState(() {
      checkLoggedInUser();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 370,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 59, 70),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(200),
                      bottomLeft: Radius.circular(200),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Let's Start",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w100,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: [Colors.orange, Color.fromARGB(255, 244, 177, 54), Color.fromARGB(255, 11, 136, 158)],
                              ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "From Today",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w100,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: [Colors.orange, Color.fromARGB(255, 244, 177, 54), Color.fromARGB(255, 11, 136, 158)],
                              ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                              fillColor: const Color.fromARGB(255, 207, 206, 206),
                              filled: true,
                              hintText: 'Username',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 90,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 167,
            top: 344,
            child: ClipOval(
              child: ElevatedButton(
              
                onPressed: () {
                if (_formKey.currentState!.validate()) {
                loginConform(context);
              } else {
                print('Data is Empty');
              }
                },
                child: Icon(Icons.keyboard_arrow_right),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                    shape: CircleBorder(), minimumSize: Size(50, 50)),
              ),
            ),
          ),
          Positioned(
              right: 8,
              top: 370,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  'asset/vecteezy_clock-icon-clipart-design-illustration_9342688_130.png',
                  height: 140,
                  width: 140,
                ),
              )),
              Positioned(
                top: 415,
                left: 15,
                child: appTexts(text1: 'Task Management:',
                text2: 'A to-do list app allows you to list and\ncategorize tasks based on different\nprojects,deadlines, or contexts. This \nmakes it easierto keep track of various\nresponsibilities and activities.'
                ),
              ),
              Positioned(
                top: 520,
                left: 15,
                child: appTexts(text1: 'Goal Setting:',
                text2: 'To-do list apps can be used for setting both \nshort-term and long-termgoals. Breaking down larger\n goals into smaller tasks makes\nthem more achievable and manageable.'
                ),
              ),
              Positioned(
                top: 610,
                left: 15,
                child: appTexts(text1: 'Productivity Boost:',
                text2: 'Crossing off completed tasks from your to-do list provides a\nsense of accomplishment and motivates you to tackle more\ntasks. This sense of achievement can boost your overall\nproductivity.'
                ),
              ),
              Positioned(
                top: 706,
                left: 15,
                child: appTexts(text1: 'Flexibility:',
                text2: 'Digital to-do lists can be easily updated, modified\nand reorganized. This adaptability is especially useful\nwhen priorities change or new tasks emerge.'
                ),
              ),
        ],
      ),
    );
  }

  Align appTexts({String? text1,String? text2}) {
    return Align(
  alignment: Alignment.centerLeft,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text1!,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 77, 76, 76),
        ),
      ),
      Text(
        text2!,
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    ],
  ),
);
}
    void loginConform(BuildContext ctx) async {
    final name = _nameController.text;
    if (name.isNotEmpty) {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString(SAVE_KEY_NAME, name);
      navigateToBottomNavigation(ctx);
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Text("Username is empty"),
      ));
    }
  }
    void navigateToBottomNavigation(BuildContext ctx) {
      Navigator.of(ctx).push(
    MaterialPageRoute(builder: (context) => BottomNavigation(username:_nameController.text)),
  );
  }
}
