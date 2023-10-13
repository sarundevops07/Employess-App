// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';
import 'package:employees_app/db/functions/db_functions.dart';
import 'package:employees_app/db/model/model.dart';
import 'package:employees_app/widgets/add_photo.dart';
import 'package:employees_app/widgets/button.dart';
import 'package:employees_app/widgets/drawer.dart';
import 'package:employees_app/widgets/sized.dart';
import 'package:employees_app/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEditDetails extends StatefulWidget {
  final String? addUpdatePhoto;
  final String? textOfButton;
  final EmployeeModel? employeeData;
  final Function(File?)? onImageSelected;
  const AddEditDetails(
      {super.key,
      this.addUpdatePhoto,
      this.textOfButton,
      this.employeeData,
      this.onImageSelected});
  @override
  State<AddEditDetails> createState() => _AddEditDetailsState();
}

class _AddEditDetailsState extends State<AddEditDetails> {
  ColorTheme instanceOfColor = ColorTheme(0);
  final String avtarDP = "lib/assets/avatar.webp";
  File? imageFromPhone;
  final nameController = TextEditingController();

  final salaryController = TextEditingController();

  final domainController = TextEditingController();

  final ageController = TextEditingController();

  Future<void> galleryPicker() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        imageFromPhone = File(imagePicked.path);
        // widget.onImageSelected(imageFromPhone); // Call the callback function
      });
    }
  }

  Future<void> cameraPicker() async {
    final imageClicked =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageClicked != null) {
      setState(() {
        imageFromPhone = File(imageClicked.path);
        //  widget.onImageSelected(imageFromPhone); // Call the callback function
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    File? imageFromPhone;
    return Center(
      child: Column(
        children: [
          AddPhoto(
            photoText: widget.addUpdatePhoto ?? "",
            onImageSelected: (image) => setState(() {
              print("object" + image.toString());
              imageFromPhone = image;
            }),
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
              submitButtonPressed(context, imageFromPhone.toString());
              print("image from phone valueee isssssssssss" +
                  imageFromPhone.toString());
            },
          )
        ],
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
      print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk" + image);
      DataBaseFunctions().addDetails(employeeData);
      Navigator.pushNamed(ctx, "HomeScreen");
    }
  }
}
