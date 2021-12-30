import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:number_trivia_v2/core/network/network_info.dart';
import 'package:number_trivia_v2/core/utils/input_converter.dart';
import 'package:number_trivia_v2/features/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia_v2/features/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_v2/features/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia_v2/features/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia_v2/features/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_v2/features/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia_v2/features/presentation/bloc/number_trivia_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<NumberTriviaBloc>(
    () => NumberTriviaBloc(
      getRandomNumberTrivia: sl(),
      getConcreteNumberTrivia: sl(),
      inputConverter: sl(),
    ),
  );

// usecases
  sl.registerLazySingleton<GetRandomNumberTrivia>(
      () => GetRandomNumberTrivia(repository: sl()));
  sl.registerLazySingleton<GetConcreteNumberTrivia>(
      () => GetConcreteNumberTrivia(repository: sl()));

// repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      localDataSource: sl(),
    ),
  );

// data source
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(preferences: sl()));

  // core
  sl.registerLazySingleton<InputConverter>(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(checker: sl()));

  // external
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());
  final preferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => preferences);
}
