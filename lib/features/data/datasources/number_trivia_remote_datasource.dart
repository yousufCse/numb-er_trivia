import 'dart:convert';

import 'package:number_trivia_v2/core/error/exceptions.dart';
import 'package:number_trivia_v2/features/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getRandomNumberTrivia();
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getNumberTriviaFromUrl('http://numbersapi.com/random/trivia');

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getNumberTriviaFromUrl('http://numbersapi.com/$number');

  Future<NumberTriviaModel> _getNumberTriviaFromUrl(String url) async {
    final newUrl = Uri.parse(url);

    final http.Response response = await client.get(newUrl, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final json = await jsonDecode(response.body);
      return NumberTriviaModel.fromJson(json);
    } else {
      throw ServerException();
    }
  }
}
