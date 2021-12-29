import 'package:flutter/material.dart';
import 'package:number_trivia_v2/features/domain/entities/number_trivia.dart';

class DisplayTrivia extends StatelessWidget {
  final NumberTrivia trivia;
  const DisplayTrivia({Key? key, required this.trivia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        trivia.text,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
