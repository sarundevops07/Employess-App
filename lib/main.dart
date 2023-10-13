import 'package:employees_app/db/model/model.dart';
import 'package:employees_app/screens/add_employee.dart';
import 'package:employees_app/screens/home_page.dart';
import 'package:employees_app/screens/login_page.dart';
import 'package:employees_app/screens/splash_screen.dart';
import 'package:employees_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter(); // Initialize Hive
  EmployeeModelAdapter refOfModel = EmployeeModelAdapter();
  if (!Hive.isAdapterRegistered(refOfModel.typeId)) {
    Hive.registerAdapter(refOfModel);
  }
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
      home: Scaffold(
        body: HomePagee(isDarkModeOnHome: isDarkModeOn),
      ),
      routes: {
        "Splashscreen": (context) => const SplashScreen(),
        "LoginScreen": (context) => const LoginPage(),
        "HomeScreen": (context) => HomePagee(isDarkModeOnHome: isDarkModeOn),
        "AddEmployee": (context) => const AddEmployee(),
      },
    );
  }
}
