import 'package:employees_app/db/model/model.dart';
import 'package:employees_app/screens/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<EmployeeModel>> employeeListNotifier = ValueNotifier([]);

// Future<void> addDetails(EmployeeModel value) async {
//   print("addDetails finction called");
//   await Hive.openBox<EmployeeModel>("employee_db"); // Open the box
//   final employeeDB = Hive.box<EmployeeModel>("employee_db");
//   int key = await employeeDB.add(value);
//   value.deletionKey = key;
//   print("Employee added: $value"); // Print the added employee for debugging
//   employeeListNotifier.value.add(value);
//   employeeListNotifier.notifyListeners();
// }
Future<void> addDetails(EmployeeModel value) async {
  print("addDetails function called");
  try {
    await Hive.openBox<EmployeeModel>("employee_db"); // Open the box

    final employeeDB = Hive.box<EmployeeModel>("employee_db");
    int key = await employeeDB.add(value);
    value.deletionKey = key;
    print("Employee added: $value"); // Print the added employee for debugging
    employeeListNotifier.value.add(value);
    employeeListNotifier.notifyListeners();
  } catch (e) {
    print("Error adding employee: $e");
    // Handle the error appropriately (e.g., show an error message to the user)
  }
}
// Future<void> addDetails(EmployeeModel value) async {
//   print("addDetails function called");
//   try {
//     if (value.name == null || value.name.isEmpty) {
//       throw Exception("Employee name is required");
//     } else if (value.domain == null || value.domain.isEmpty) {
//       throw Exception("Employee Domain is required");
//     } else if (value.salary == null || value.salary.isEmpty) {
//       throw Exception("Employee salary is required");
//     } else if (value.age == null || value.age.isEmpty) {
//       throw Exception("Employee age is required");
//     } else if (value.imageFromPhone == null || value.imageFromPhone.isEmpty) {
//       throw Exception("Employee image is required");
//     }
//     await Hive.openBox<EmployeeModel>("employee_db"); // Open the box
//     final employeeDB = Hive.box<EmployeeModel>("employee_db");
//     int key = await employeeDB.add(value);
//     value.deletionKey = key;
//     print("Employee added: $value"); // Print the added employee for debugging
//     employeeListNotifier.value.add(value);
//     employeeListNotifier.notifyListeners();
//   } catch (e) {
//     print("Error adding employee: $e");
//     // Handle the error appropriately (e.g., show an error message to the user)
//   }
// }

// Future<void> getAllEmployees() async {
//   print("getAllEmployees function called");
//   await Hive.openBox<EmployeeModel>("employee_db"); // Open the box
//   final employeeDB = Hive.box<EmployeeModel>("employee_db");
//   employeeListNotifier.value.clear();

//   final List<EmployeeModel> employees = employeeDB.values.toList();
//   print("Retrieved employees from database: $employees");
//   for (int i = 0; i < employees.length; i++) {
//     employees[i].deletionKey = employeeDB.keyAt(i);
//   }

//   employeeListNotifier.value.addAll(employees);
//   employeeListNotifier.notifyListeners();
// }
Future<void> getAllEmployees() async {
  //print("getAllEmployees function called");
  await Hive.openBox<EmployeeModel>("employee_db"); // Open the box
  final employeeDB = Hive.box<EmployeeModel>("employee_db");
  employeeListNotifier.value.clear();
  employersList.clear(); // Clear the employeeList before populating it again
  //filteredEmployeeList.clear(); // Clear the filteredEmployeeList as well

  final List<EmployeeModel> employees = employeeDB.values.toList();
  // print("Retrieved employees from database: $employees");
  for (int i = 0; i < employees.length; i++) {
    employees[i].deletionKey = employeeDB.keyAt(i);
  }
  employersList.addAll(employees);
  //filteredEmployeeList.addAll(employees);
  employeeListNotifier.value = List<EmployeeModel>.from(employersList);
  employeeListNotifier.notifyListeners();
}

Future<void> removeDetails(int id) async {
  await Hive.openBox<EmployeeModel>("employee_db");
  final employeeDB = Hive.box<EmployeeModel>("employee_db");
  await employeeDB.delete(id);
  await getAllEmployees();
}
// Future<void> getAllEmployees() async {
//   await Hive.openBox<EmployeeModel>("employee_db"); // Open the box
//   final employeeDB = Hive.box<EmployeeModel>("employee_db");
//   employeeListNotifier.value.clear();
//   employeeListNotifier.value.addAll(employeeDB.values);
//   employeeListNotifier.notifyListeners();
// }