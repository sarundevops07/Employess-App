import 'package:employees_app/widgets/add_edit_details.dart';
import 'package:employees_app/widgets/drawer.dart';
import 'package:employees_app/widgets/theme.dart';
import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});
  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  ColorTheme instanceOfColor = ColorTheme(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkModeOn
          ? instanceOfColor.darkModeBlack
          : instanceOfColor.whiteColor,
      appBar: AppBar(
        title: const Text(
          "Add Details",
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 500,
            child: Column(
              children: [
                AddEditDetails(
                  addUpdatePhoto: "Add a Photo",
                  textOfButton: "Submit",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
