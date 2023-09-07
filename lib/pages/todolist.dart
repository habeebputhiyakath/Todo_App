import 'package:flutter/material.dart';

class toDolist extends StatelessWidget {
  final String taskName;
  final bool tasComplete;
  Function(bool?)? onChanged;
  

  toDolist({
    super.key,
    required this.taskName,
    required this.tasComplete,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.grey[100],
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                    value: tasComplete,
                    onChanged: onChanged,
                    activeColor: Colors.green,
                    hoverColor: Colors.grey[200]),
                Text(
                  taskName,
                  style: TextStyle(
                      decoration: tasComplete
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    )),
                SizedBox(
                  width: 7,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.delete,
                      color: Colors.red[900],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
