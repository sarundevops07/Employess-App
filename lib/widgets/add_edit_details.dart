import 'dart:io';
import 'package:employees_app/db/functions/db_functions.dart';
import 'package:employees_app/db/model/model.dart';
import 'package:employees_app/widgets/add_photo.dart';
import 'package:employees_app/widgets/drawer.dart';
import 'package:employees_app/widgets/sized.dart';
import 'package:employees_app/widgets/text_field.dart';
import 'package:employees_app/widgets/theme.dart';
import 'package:flutter/material.dart';

class AddEditDetails extends StatefulWidget {
  final String? addUpdatePhoto;
  final String? textOfButton;

  const AddEditDetails({
    super.key,
    this.addUpdatePhoto,
    this.textOfButton,
  });

  @override
  State<AddEditDetails> createState() => _AddEditDetailsState();
}

class _AddEditDetailsState extends State<AddEditDetails> {
  ColorTheme instanceOfColor = ColorTheme(0);
  final nameController = TextEditingController();

  final salaryController = TextEditingController();

  final domainController = TextEditingController();

  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    File? imageFromPhone;
    return Center(
      child: Column(
        children: [
          AddPhoto(
            photoText: widget.addUpdatePhoto ?? "",
            onImageSelected: (image) => imageFromPhone = image,
          ),
          const Sized(heights: 20),
          TextFieldMyApp(hintText: "name", controllers: nameController),
          const Sized(heights: 20),
          TextFieldMyApp(hintText: "salary", controllers: salaryController),
          const Sized(heights: 20),
          TextFieldMyApp(hintText: "domain", controllers: domainController),
          const Sized(heights: 20),
          TextFieldMyApp(hintText: "age", controllers: ageController),
          const Sized(heights: 20),
          SizedBox(
            height: 35,
            width: 80,
            child: ElevatedButton(
              onPressed: () {
                print("button not clicked");
                submitButtonPressed(
                  context,
                  imageFromPhone.toString(),
                );
                print("button clicked");
              },
              child: const Text("Submit"),
            ),
          )
        ],
      ),
    );
  }

  dynamic submitButtonPressed(BuildContext ctx, String image) {
    final String name = nameController.text;
    final salary = salaryController.text;
    final domain = domainController.text;
    final age = ageController.text;
    if (name.isEmpty ||
        salary.isEmpty ||
        domain.isEmpty ||
        age.isEmpty ||
        image.isEmpty) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: isDarkModeOn
              ? instanceOfColor.greyColor
              : instanceOfColor.tealColor200,
          duration: const Duration(seconds: 3),
          content: const Text(
            textAlign: TextAlign.center,
            "Field can't be empty",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
      return;
    } else {
      EmployeeModel employeeData = EmployeeModel(
          age: age,
          domain: domain,
          name: name,
          salary: salary,
          imageFromPhone: image.toString());
      print("Path is here: ${employeeData.imageFromPhone}");
      addDetails(
        employeeData,
      );
      Navigator.pushNamed(
        ctx,
        "HomeScreen",
      );
    }
  }
}
