import 'dart:io';
import 'package:employees_app/db/functions/db_functions.dart';
import 'package:employees_app/db/model/model.dart';
import 'package:employees_app/screens/employee_details.dart';
import 'package:employees_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/theme.dart';

class HomePagee extends StatefulWidget {
  const HomePagee({Key? key}) : super(key: key);

  @override
  State<HomePagee> createState() => _HomePageeState();
}

List<EmployeeModel> employersList = [];
List<EmployeeModel> filteredEmployeeList = [];

class _HomePageeState extends State<HomePagee> {
  ColorTheme instanceOfColor = ColorTheme(0);

  TextEditingController editingController = TextEditingController();
  // List<EmployeeModel> employeeList = [];
  // List<EmployeeModel> filteredEmployeeList = [];
  bool showSearchBar = false;

  @override
  void initState() {
    super.initState();
    getAllEmployees();
  }

  void filterSearchResults(String query) {
    print("Search query: $query"); // Add this print statement
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
    getAllEmployees();
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
      body: Consumer(
        builder: (context, darkModeProvider, child) {
          return ValueListenableBuilder(
            valueListenable: employeeListNotifier,
            builder: (context, List<EmployeeModel> employeeList, child) {
              // print("builder function executed");
              // print("Employee list length: ${employeeList.length}");
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
                      // print(data.name);
                      // print(data.domain);
                      // print(data.salary);
                      // print(data.age);
                      // print(data.imageFromPhone);
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
                                  showDeleteConfirmationDialog(
                                      context, employee);
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
                          backgroundImage: FileImage(
                            File(data.imageFromPhone),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: displayedList.length);
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkModeOn
            ? instanceOfColor.greyColor
            : instanceOfColor.tealColor,
        onPressed: () => Navigator.pushNamed(context, "AddEmployee"),
        child: const Icon(Icons.add),
      ),
      backgroundColor: isDarkModeOn
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
                Navigator.pop(context); // Close the dialog
                if (data.deletionKey != null) {
                  removeDetails(
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
                Navigator.pop(context); // Close the current page
                Navigator.pushNamed(
                    context, "HomePage"); // Navigate to the home page
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
// import 'package:employees_app/db/functions/db_functions.dart';
// import 'package:employees_app/db/model/model.dart';
// import 'package:employees_app/widgets/drawer.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class HomePagee extends StatefulWidget {
//   const HomePagee({Key? key}) : super(key: key);

//   @override
//   State<HomePagee> createState() => _HomePageeState();
// }

// class _HomePageeState extends State<HomePagee> {
//   late Box<EmployeeModel> _employeeBox;
//   late ValueListenable<Box<EmployeeModel>> _employeeBoxListenable;

//   @override
//   void initState() {
//     super.initState();
//     openEmployeeBox();
//   }

//   Future<void> openEmployeeBox() async {
//     await Hive.openBox<EmployeeModel>("employee_db");
//     _employeeBox = Hive.box<EmployeeModel>("employee_db");
//     _employeeBoxListenable = _employeeBox.listenable();
//     getAllEmployees();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const Drawer(
//         child: Drawers(),
//       ),
//       appBar: AppBar(
//         title: const Text("Home Page"),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () => Navigator.pushNamed(context, "AddEmployee"),
//             icon: const Icon(Icons.add),
//           ),
//         ],
//       ),
//       body: ValueListenableBuilder<Box<EmployeeModel>>(
//         valueListenable: _employeeBoxListenable,
//         builder: (context, box, child) {
//           final employeeList = box.values.toList();

//           if (employeeList.isEmpty) {
//             return const Center(
//               child: Text(
//                 "No data available",
//                 style: TextStyle(fontSize: 20),
//               ),
//             );
//           } else {
//             return ListView.separated(
//               itemBuilder: (context, index) {
//                 final data = employeeList[index];
//                 return ListTile(
//                   title: Text(data.name),
//                   subtitle: Text(data.domain),
//                   trailing: IconButton(
//                     onPressed: () {
//                       if (data.deletionKey != null) {
//                         removeDetails(data.deletionKey!);
//                       } else {
//                         print("key has a null value");
//                       }
//                     },
//                     icon: const Icon(
//                       Icons.delete,
//                       color: Colors.red,
//                     ),
//                   ),
//                   leading: const CircleAvatar(
//                     backgroundImage: AssetImage(
//                       "lib/assets/avatar.webp",
//                     ),
//                   ),
//                 );
//               },
//               separatorBuilder: (context, index) => const Divider(),
//               itemCount: employeeList.length,
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//}
