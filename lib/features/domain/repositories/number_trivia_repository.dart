import 'package:dartz/dartz.dart';
import 'package:number_trivia_v2/core/error/failures.dart';
import 'package:number_trivia_v2/features/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
}
