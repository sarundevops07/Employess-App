import 'package:employees_app/db/model/model.dart';
import 'package:employees_app/screens/add_employee.dart';
import 'package:employees_app/screens/edit_employee_details.dart';
import 'package:employees_app/screens/home_page.dart';
import 'package:employees_app/screens/login_page.dart';
import 'package:employees_app/screens/splash_screen.dart';
import 'package:employees_app/widgets/dark_mode_provider.dart';
import 'package:employees_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter(); // Initialize Hive
  EmployeeModelAdapter refOfModel = EmployeeModelAdapter();
  // if (!Hive.isAdapterRegistered(refOfModel.typeId)) {}
  Hive.registerAdapter(refOfModel);
  // await Hive.openBox<EmployeeModel>("employee_db"); // Open the box
  runApp(
    const MyApp(),
  );
}

const String avtarDP = "lib/assets/avatar.webp";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData(primarySwatch: Colors.teal);
    ThemeData themeDarkMode = ThemeData(primarySwatch: Colors.grey);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkModeOn ? themeDarkMode : theme,
      home: const Scaffold(
        body: HomePagee(),
      ),
      routes: {
        "Splashscreen": (context) => const SplashScreen(),
        "LoginScreen": (context) => const LoginPage(),
        "HomeScreen": (context) => const HomePagee(),
        "AddEmployee": (context) => const AddEmployee(),
        // "EmployeeDetails": (context) => EmployeeDetails(),
        "EditEmployeeDetails": (context) => EditEmployeeDetails()
      },
    );
  }
}
