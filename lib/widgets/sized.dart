import 'package:flutter/cupertino.dart';

class Sized extends StatelessWidget {
  final double heights;
  const Sized({super.key, required this.heights});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heights,
    );
  }
}
