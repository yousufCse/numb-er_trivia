import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:number_trivia_v2/core/error/exceptions.dart';
import 'package:number_trivia_v2/core/error/failures.dart';
import 'package:number_trivia_v2/features/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl(this.client);

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    final url = Uri.parse('http://numbersapi.com/random/trivia');

    final http.Response response = await client.get(url, headers: {
      'Content_Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return NumberTriviaModel.fromJson(json);
    } else {
      throw ServerException();
    }
  }
}
