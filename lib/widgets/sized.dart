import 'package:flutter/cupertino.dart';

class Sized extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final double heights;
  const Sized({super.key, required this.heights});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heights,
    );
  }
}
