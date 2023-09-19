import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  CustomCheckbox({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: value ? Colors.green : Colors.grey,
            width: 2.0,
          ),
        ),
        child: value
            ? Icon(
                Icons.check,
                size: 20.0,
                color: Colors.green, 
              )
            : null,
      ),
    );
  }
}
