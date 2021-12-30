import 'dart:convert';

import 'package:number_trivia_v2/core/error/exceptions.dart';
import 'package:number_trivia_v2/features/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String SP_TRIVIA = 'NUMBER_TRIVIA';

abstract class NumberTriviaLocalDataSource {
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTrivia);

  Future<NumberTriviaModel> getLatestNumberTrivia();
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences preferences;

  NumberTriviaLocalDataSourceImpl({required this.preferences});

  @override
  Future<NumberTriviaModel> getLatestNumberTrivia() {
    final jsonString = preferences.getString(SP_TRIVIA);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTrivia) async {
    await preferences.setString(
      SP_TRIVIA,
      jsonEncode(numberTrivia.toJson()),
    );
  }
}
