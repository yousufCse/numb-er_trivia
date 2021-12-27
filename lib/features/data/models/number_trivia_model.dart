import 'package:number_trivia_v2/features/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  final String text;
  final String number;

  const NumberTriviaModel({
    required this.text,
    required this.number,
  }) : super(
          text: text,
          number: number,
        );

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json['text'],
      number: json['number'].toString(),
    );
  }
}
