import 'dart:io';
import 'package:employees_app/db/functions/db_functions.dart';
import 'package:employees_app/db/model/model.dart';
import 'package:employees_app/widgets/add_photo.dart';
import 'package:employees_app/widgets/button.dart';
import 'package:employees_app/widgets/drawer.dart';
import 'package:employees_app/widgets/sized.dart';
import 'package:employees_app/widgets/theme.dart';
import 'package:flutter/material.dart';

class EditEmployeeDetails extends StatefulWidget {
  final String addUpdatePhoto;
  final String textOfButton;
  final EmployeeModel employeeData;
  const EditEmployeeDetails(
      {super.key,
      required this.addUpdatePhoto,
      required this.textOfButton,
      required this.employeeData});
  @override
  State<EditEmployeeDetails> createState() => _EditEmployeeDetailsState();
}

class _EditEmployeeDetailsState extends State<EditEmployeeDetails> {
  ColorTheme instanceOfColor = ColorTheme(0);

  TextEditingController nameController = TextEditingController();

  TextEditingController salaryController = TextEditingController();

  TextEditingController domainController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.employeeData.name;
    salaryController.text = widget.employeeData.salary;
    domainController.text = widget.employeeData.domain;
    ageController.text = widget.employeeData.age;
    File? imageFromPhone;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Employee Details"),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          height: 500,
          child: Column(
            children: [
              AddPhoto(
                photoText: "Update Photo",
                onImageSelected: (image) => imageFromPhone = image,
              ),
              const Sized(heights: 20),
              textField(hintText: "name", controllers: nameController),
              const Sized(heights: 20),
              textField(hintText: "salary", controllers: salaryController),
              const Sized(heights: 20),
              textField(hintText: "domain", controllers: domainController),
              const Sized(heights: 20),
              textField(hintText: "age", controllers: ageController),
              const Sized(heights: 20),
              Button(
                  buttonText: widget.textOfButton,
                  onPress: (context) {
                    updateButtonPressed(
                      imageFromPhone.toString(),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(
      {String? hintText, bool? obscure, TextEditingController? controllers}) {
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

  dynamic updateButtonPressed(String image) {
    final String name = nameController.text;
    final String salary = salaryController.text;
    final String domain = domainController.text;
    final String age = ageController.text;

    EmployeeModel updatedEmployeeData = EmployeeModel(
      age: age,
      domain: domain,
      name: name,
      salary: salary,
      imageFromPhone: image,
      deletionKey: widget.employeeData.deletionKey,
    );
    DataBaseFunctions().updateDetails(updatedEmployeeData);
    Navigator.popAndPushNamed(context, "HomeScreen");
  }
}
