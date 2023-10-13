import 'package:employees_app/widgets/drawer.dart';
import 'package:employees_app/widgets/sized.dart';
import 'package:employees_app/screens/splash_screen.dart';
import 'package:employees_app/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ColorTheme instanceOfColor = ColorTheme(0);
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: instanceOfColor.whiteColor,
      body: SafeArea(
        child: Center(
          child: Container(
            height: 250,
            // color: Colors.amber,
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                textField(
                  hintText: "username",
                  controllers: userNameController,
                ),
                const Sized(heights: 20),
                textField(
                  hintText: "password",
                  controllers: passwordController,
                  obscure: true,
                ),
                const Sized(heights: 20),
                SizedBox(
                  height: 35,
                  width: 80,
                  child: ElevatedButton(
                    onPressed: () {
                      loginCheck(context);
                    },
                    child: const Text("Submit"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginCheck(BuildContext ctx) async {
    const String savedUserName = "sarun";
    const String savedPassword = "7736159897";
    final userName = userNameController.text;
    final password = passwordController.text;
    // ignore: unrelated_type_equality_checks
    if (savedUserName == userName && savedPassword == password) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(saveKey, true);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, "HomeScreen");
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: Colors.teal[200],
          duration: const Duration(seconds: 3),
          content: const Text(
            "Incorrect Password",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
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
}
