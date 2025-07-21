import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  @override
  State<MyCheckbox> createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value ?? false;
        });
      },
      activeColor: Color.fromRGBO(191, 49, 49, 1.0), // 체크됐을 때 색상
    );
  }
}
