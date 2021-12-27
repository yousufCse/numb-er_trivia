import 'package:flutter/material.dart';

class DisplayError extends StatelessWidget {
  final String text;
  const DisplayError({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20.0, color: Colors.red),
    );
  }
}
