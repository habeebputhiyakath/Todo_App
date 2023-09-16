import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_manager.dart';

class toDolist extends StatelessWidget {
  final String taskName;
  final bool tasComplete;
  final Function(bool?)? onChanged;
  final Function(BuildContext?)? deleteFunction;
  
  

  toDolist({
    super.key,
    required this.taskName,
    required this.tasComplete,
    required this.onChanged,
    required this.deleteFunction,
    
  });
  TextEditingController dialogueController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
  width: double.infinity, 
  height: 80, 
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), 
  ),
  child: Card(
  color: themeManager.headingsColor,
  elevation: 10,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Checkbox(
        value: tasComplete,
        onChanged: onChanged,
        activeColor: Colors.green,
        hoverColor: Colors.grey[200],
      ),
      Expanded(
        child: Text(
          taskName,
          style: TextStyle(
            decoration: tasComplete
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
      ),
      InkWell(
        onTap: () {
          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Edit Task'),
                              content: TextFormField(
                                controller: dialogueController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 4, 18, 94)),
                                )),
                              ),
                              actions: <Widget>[
                                TextButton(
                                    child: Text('Save'),
                                    onPressed: () {
                                      
                                    }),
                                TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                              ],
                            );
                          },
                        );
        },
        child: Icon(
          Icons.edit,
          color: Colors.grey,
        ),
      ),
      SizedBox(
        width: 7,
      ),
      InkWell(
        onTap: () {
          deleteFunction!(context);
        },
        child: Icon(
          Icons.delete,
          color: themeManager.deleteIcons,
        ),
      )
    ],
  ),
),

)

    );
  }
}
