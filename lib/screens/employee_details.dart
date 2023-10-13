import 'package:employees_app/db/model/model.dart';
import 'package:employees_app/widgets/add_photo.dart';
import 'package:employees_app/widgets/drawer.dart';
import 'package:employees_app/widgets/sized.dart';
import 'package:employees_app/widgets/theme.dart';
import 'package:flutter/material.dart';

enum Options { edit, delete }

class EmployeeDetails extends StatefulWidget {
  final Function(EmployeeModel) onDeleteSelected;
  final EmployeeModel employeeData;

  const EmployeeDetails({
    super.key,
    required this.employeeData,
    required this.onDeleteSelected,
  });

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  ColorTheme instanceOfColor = ColorTheme(0);
  // ignore: unused_field
  var _popupMenuItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkModeOn
          ? instanceOfColor.blackColor
          : instanceOfColor.whiteColor,
      appBar: AppBar(
        title: const Text(
          "Employee Details",
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (value) => onMenuItemSelected(value as int),
            itemBuilder: (context) => [
              PopupMenuItem(
                child:
                    popUpList(itemName: "Edit", position: Options.edit.index),
              ),
              PopupMenuItem(
                child: popUpList(
                    itemName: "delete", position: Options.delete.index),
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: SizedBox(
          // color: Colors.blueGrey,
          height: 600,
          child: Column(
            children: [
              const Sized(heights: 20),
              AddPhoto(
                photoText: "Profile Photo",
                onImageSelected: (p0) {},
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                //  height: 500,
                height: MediaQuery.of(context).size.width,
                // color: Colors.amber,
                child: Card(
                  color: isDarkModeOn
                      ? instanceOfColor.greyColor
                      : instanceOfColor.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Sized(heights: 20),
                      card(widget.employeeData.name),
                      const Sized(heights: 20),
                      card(widget.employeeData.salary),
                      const Sized(heights: 20),
                      card(widget.employeeData.domain),
                      const Sized(heights: 20),
                      card(widget.employeeData.age),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget card(String data) {
    return Text(
      data,
      style: const TextStyle(
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  Widget popUpList({String? itemName, int? position}) {
    return PopupMenuItem(
      value: position,
      child: Text(itemName ?? ""),
    );
  }

  onMenuItemSelected(var value) {
    setState(() {
      _popupMenuItemIndex = value;
    });
    if (value == Options.edit.index) {
      // Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      //   return EditEmployeeDetails(
      //     addUpdatePhoto: widget.employeeData.imageFromPhone.toString(),
      //     textOfButton: "Update",
      //     employeeData: widget.employeeData,
      //   );
      // }));
    } else if (value == Options.delete.index) {
      widget.onDeleteSelected(widget.employeeData);
    }
  }
}
