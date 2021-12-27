import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Welcome to Number Trivia App',
      style: TextStyle(
        fontSize: 18.0,
      ),
    );
  }
}
