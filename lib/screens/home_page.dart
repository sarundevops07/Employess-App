import 'dart:io';
import 'package:employees_app/db/functions/db_functions.dart';
import 'package:employees_app/db/model/model.dart';
import 'package:employees_app/screens/employee_details.dart';
import 'package:employees_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import '../widgets/theme.dart';

class HomePagee extends StatefulWidget {
  final bool isDarkModeOnHome;

  const HomePagee({
    Key? key,
    required this.isDarkModeOnHome,
  }) : super(key: key);

  @override
  State<HomePagee> createState() => _HomePageeState();
}

List<EmployeeModel> employersList = [];
List<EmployeeModel> filteredEmployeeList = [];

class _HomePageeState extends State<HomePagee> {
  ColorTheme instanceOfColor = ColorTheme(0);
  TextEditingController editingController = TextEditingController();
  bool showSearchBar = false;

  @override
  void initState() {
    super.initState();
    DataBaseFunctions().getAllEmployees();
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredEmployeeList = employersList
          .where((employee) =>
              employee.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void resetSearch() {
    setState(() {
      filteredEmployeeList = List<EmployeeModel>.from(employersList);
    });
  }

  Widget buildSearchField() {
    return TextField(
      onChanged: (value) {
        filterSearchResults(value);
      },
      controller: editingController,
      decoration: const InputDecoration(
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DataBaseFunctions().getAllEmployees();
    return Scaffold(
      drawer: const Drawer(
        child: Drawers(),
      ),
      appBar: AppBar(
        title: showSearchBar
            ? buildSearchField()
            : const Text(
                "Home Page",
              ),
        centerTitle: true,
        actions: [
          showSearchBar
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showSearchBar = false;
                      resetSearch();
                    });
                  },
                  icon: const Icon(Icons.close),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      showSearchBar = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: employeeListNotifier,
        builder: (context, List<EmployeeModel> employeeList, child) {
          if (employeeList.isEmpty) {
            return const Center(
              child: Text(
                "No data available",
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            // Filter the list based on search query
            final List<EmployeeModel> displayedList =
                editingController.text.isNotEmpty
                    ? filteredEmployeeList
                    : employeeList;
            //Sort the displayed list (optional)
            displayedList.sort((a, b) => a.name.compareTo(b.name));
            if (displayedList.isEmpty) {
              return const Center(
                child: Text(
                  "No results found",
                  style: TextStyle(fontSize: 20),
                ),
              );
            }

            return ListView.separated(
                itemBuilder: (context, index) {
                  final data = displayedList[index];
                  return ListTile(
                    title: Text(
                      data.name,
                      style: TextStyle(
                          color: isDarkModeOn
                              ? instanceOfColor.whiteColor
                              : instanceOfColor.blackColor),
                    ),
                    subtitle: Text(
                      data.domain,
                      style: TextStyle(
                          color: isDarkModeOn
                              ? instanceOfColor.whiteColor
                              : instanceOfColor.blackColor),
                    ),
                    onLongPress: () =>
                        showDeleteConfirmationDialog(context, data),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmployeeDetails(
                            employeeData: data,
                            onDeleteSelected: (employee) {
                              showDeleteConfirmationDialog(context, employee);
                            },
                          ),
                        ),
                      );
                    },
                    trailing: IconButton(
                      onPressed: () {
                        showDeleteConfirmationDialog(context, data);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: Image.file(
                        File(data.imageFromPhone),
                      ).image,
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: displayedList.length);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkModeOn
            ? instanceOfColor.greyColor
            : instanceOfColor.tealColor,
        onPressed: () => Navigator.pushNamed(context, "AddEmployee"),
        child: const Icon(Icons.add),
      ),
      backgroundColor: widget.isDarkModeOnHome
          ? instanceOfColor.darkModeBlack
          : instanceOfColor.whiteColor,
    );
  }

  void showDeleteConfirmationDialog(BuildContext ctx, EmployeeModel data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDarkModeOn
              ? instanceOfColor.greyColor
              : instanceOfColor.whiteColor,
          title: Text("Delete ${data.name}"),
          content: Text(
            "Are you sure to delete ${data.name}",
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.red,
                ),
              ),
              onPressed: () {
                // Navigator.pop(context); // Close the dialog
                if (data.deletionKey != null) {
                  DataBaseFunctions().removeDetails(
                    data.deletionKey!,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: isDarkModeOn
                          ? instanceOfColor.greyColor
                          : instanceOfColor.tealColor200,
                      content: Text(
                        "${data.name} deleted",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
                // Navigate back to the home page
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, "HomePage");
                // Close the current page
                // Navigate to the home page
              },
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dailog
              },
              child: const Text(
                "No",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        );
      },
    );
  }
}
