import 'package:get_it/get_it.dart';
import 'package:number_trivia_v2/features/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_v2/features/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia_v2/features/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia_v2/features/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_v2/features/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia_v2/features/presentation/bloc/number_trivia_bloc.dart';
import 'package:http/http.dart' as http;

GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<NumberTriviaBloc>(
    () => NumberTriviaBloc(
      getRandomNumberTrivia: sl(),
      getConcreteNumberTrivia: sl(),
    ),
  );

// usecases
  sl.registerLazySingleton<GetRandomNumberTrivia>(
      () => GetRandomNumberTrivia(repository: sl()));
  sl.registerLazySingleton<GetConcreteNumberTrivia>(
      () => GetConcreteNumberTrivia(repository: sl()));

  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<http.Client>(() => http.Client());
}
