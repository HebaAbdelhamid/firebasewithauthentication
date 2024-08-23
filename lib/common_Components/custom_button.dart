
import 'package:firebasewithauthentication/core/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  Color bgColor = AppStyle.primaryColor;
  Color textColor;
  final Function() function;

  CustomButton(
      {super.key,
        required this.title,
        required this.function,
        required this.bgColor,
        required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: AppStyle.primaryColor),
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: MaterialButton(
          onPressed: function,
          child: Text(
            title,
            style: TextStyle(color: textColor, fontSize: 16),
          )),
    );
  }
}
