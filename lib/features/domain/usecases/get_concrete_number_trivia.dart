import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_v2/core/error/failures.dart';
import 'package:number_trivia_v2/core/usecase/usecase.dart';
import 'package:number_trivia_v2/features/domain/entities/number_trivia.dart';
import 'package:number_trivia_v2/features/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia
    implements UseCase<Either<Failure, NumberTrivia>, Params> {
  NumberTriviaRepository repository;

  GetConcreteNumberTrivia({required this.repository});

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) {
    return repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;
  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}
