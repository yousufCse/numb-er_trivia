import 'package:dartz/dartz.dart';
import 'package:number_trivia_v2/core/error/failures.dart';
import 'package:number_trivia_v2/core/usecase/usecase.dart';
import 'package:number_trivia_v2/features/domain/entities/number_trivia.dart';
import 'package:number_trivia_v2/features/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia
    implements UseCase<Either<Failure, NumberTrivia>, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) {
    return repository.getRandomNumberTrivia();
  }
}
