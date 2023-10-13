import 'package:employees_app/widgets/drawer.dart';
import 'package:employees_app/widgets/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldMyApp extends StatelessWidget {
  ColorTheme instanceOfColor = ColorTheme(0);
  final String? hintText;
  final bool? obscure;
  final TextEditingController? controllers;
  TextFieldMyApp({
    super.key,
    this.hintText,
    this.obscure,
    this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return textField();
  }

  Widget textField() {
    return TextField(
      controller: controllers,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        label: Text(
          hintText ?? "",
          style: TextStyle(
              color: isDarkModeOn
                  ? instanceOfColor.greyColor
                  : instanceOfColor.blackColor),
        ),
      ),
    );
  }
}
