import 'package:employees_app/db/model/model.dart';
import 'package:employees_app/screens/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<EmployeeModel>> employeeListNotifier = ValueNotifier([]);

class DataBaseFunctions extends ChangeNotifier {
  Future<void> addDetails(EmployeeModel value) async {
    await Hive.openBox<EmployeeModel>("employee_db"); // Open the box

    final employeeDB = Hive.box<EmployeeModel>("employee_db");
    int key = await employeeDB.add(value);
    value.deletionKey = key;
    employeeListNotifier.value.add(value);
    employeeListNotifier.notifyListeners();
  }

  Future<void> updateDetails(EmployeeModel updatedEmployee) async {
    await Hive.openBox<EmployeeModel>("employee_db");
    final employeeDB = Hive.box<EmployeeModel>("employee_db");

    // Get the index of the employee in the list
    final int index = employeeListNotifier.value.indexWhere(
      (employee) => employee.deletionKey == updatedEmployee.deletionKey,
    );

    // Update the employee in the database
    await employeeDB.put(updatedEmployee.deletionKey, updatedEmployee);

    // Update the employee in the employee list notifier
    employeeListNotifier.value[index] = updatedEmployee;
    employeeListNotifier.notifyListeners();
  }

  Future<void> getAllEmployees() async {
    await Hive.openBox<EmployeeModel>("employee_db"); // Open the box
    final employeeDB = Hive.box<EmployeeModel>("employee_db");
    employeeListNotifier.value.clear();
    employersList.clear(); // Clear the employeeList before populating it again

    final List<EmployeeModel> employees = employeeDB.values.toList();

    for (int i = 0; i < employees.length; i++) {
      employees[i].deletionKey = employeeDB.keyAt(i);
    }
    employersList.addAll(employees);
    employeeListNotifier.value = List<EmployeeModel>.from(employersList);
    employeeListNotifier.notifyListeners();
  }

  Future<void> removeDetails(int id) async {
    await Hive.openBox<EmployeeModel>("employee_db");
    final employeeDB = Hive.box<EmployeeModel>("employee_db");
    await employeeDB.delete(id);
    await getAllEmployees();
  }
}
