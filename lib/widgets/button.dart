import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String? buttonText;
  final Function(
    BuildContext ctx,
  ) onPress;
  const Button({super.key, required this.buttonText, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 80,
      child: ElevatedButton(
        onPressed: () => onPress(context),
        child: Text(buttonText!),
      ),
    );
  }
}
