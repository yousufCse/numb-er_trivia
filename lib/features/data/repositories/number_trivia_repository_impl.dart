import 'package:number_trivia_v2/core/error/exceptions.dart';
import 'package:number_trivia_v2/core/network/network_info.dart';
import 'package:number_trivia_v2/features/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_v2/features/data/models/number_trivia_model.dart';
import 'package:number_trivia_v2/features/domain/entities/number_trivia.dart';
import 'package:number_trivia_v2/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia_v2/features/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  NumberTriviaRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async =>
      _getTrivia(remoteDataSource.getRandomNumberTrivia());

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
          int number) async =>
      await _getTrivia(remoteDataSource.getConcreteNumberTrivia(number));

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      Future<NumberTriviaModel> getConcreteOrRadomTrivia) async {
    //
    if (await networkInfo.isConnection) {
      try {
        final trivia = await getConcreteOrRadomTrivia;
        return Right(trivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
