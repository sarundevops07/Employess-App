// ignore_for_file: must_be_immutable
import 'package:employees_app/main.dart';

import 'package:employees_app/widgets/theme.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Drawers extends StatefulWidget {
  const Drawers({super.key});
  @override
  State<Drawers> createState() => _DrawersState();
}

bool isDarkModeOn = false;

class _DrawersState extends State<Drawers> {
  ColorTheme instanceOfColor = ColorTheme(0);
  //bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    // DarkModeProvider darkModeProvider = DarkModeProvider();
    return Scaffold(
      backgroundColor:
          isDarkModeOn ? instanceOfColor.greyColor : instanceOfColor.whiteColor,
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          signOutDrawer(context),
          const SizedBox(
            height: 20,
          ),
          darkModeSwitch(),
        ],
      ),
    );
  }

  Widget darkModeSwitch() => ListTile(
        leading: const SizedBox(),
        title: const Text(
          "Dark Mode",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              isDarkModeOn = !isDarkModeOn;
            });
          },
          icon: isDarkModeOn
              ? Icon(
                  Icons.toggle_on,
                  color: Colors.green.shade800,
                )
              : Icon(
                  Icons.toggle_off,
                  color: Colors.red.shade800,
                ),
        ),
      );

  Widget signOutDrawer(BuildContext ctx) => ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage(avtarDP),
        ),
        title: const Text(
          "Sign Out",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          onPressed: () => signOut(ctx),
          icon: const Icon(Icons.exit_to_app),
        ),
      );

  signOut(BuildContext ctx) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool(saveKey, true);
    prefs.clear();
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
      ctx,
      "LoginScreen",
      (route) => false,
    );
  }
}
