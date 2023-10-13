import 'package:employees_app/widgets/add_edit_details.dart';
import 'package:employees_app/widgets/button.dart';
import 'package:employees_app/widgets/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditEmployeeDetails extends StatelessWidget {
  EditEmployeeDetails({super.key});
  ColorTheme instanceOfColor = ColorTheme(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const AddEditDetails(
            addUpdatePhoto: "Update Photo",
          ),
          Button(buttonText: "Update", onPress: () {})
        ],
      ),
    );
  }
}
