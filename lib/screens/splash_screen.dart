// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

const saveKey = "userLogedIn";

class _SplashScreenState extends State<SplashScreen> {
  String splash = "lib/assets/splash.png";

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => checkLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          splash,
        ),
      ),
    );
  }

  Future goToLoginScreen() async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
    Navigator.pushReplacementNamed(context, "LoginScreen");
  }

  Future checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userLoggedIn = prefs.getBool(saveKey);
    if (userLoggedIn == null || userLoggedIn == false) {
      goToLoginScreen();
    } else {
      Navigator.pushReplacementNamed(context, "HomeScreen");
    }
  }
}
