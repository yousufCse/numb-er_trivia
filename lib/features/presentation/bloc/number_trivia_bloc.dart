import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_v2/core/error/failures.dart';
import 'package:number_trivia_v2/core/usecase/usecase.dart';
import 'package:number_trivia_v2/core/utils/constants.dart';
import 'package:number_trivia_v2/core/utils/input_converter.dart';
import 'package:number_trivia_v2/features/domain/entities/number_trivia.dart';
import 'package:number_trivia_v2/features/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_v2/features/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  GetRandomNumberTrivia getRandomNumberTrivia;
  GetConcreteNumberTrivia getConcreteNumberTrivia;
  InputConverter inputConverter;

  NumberTriviaBloc(
      {required this.getRandomNumberTrivia,
      required this.getConcreteNumberTrivia,
      required this.inputConverter})
      : super(NumberTriviaInitial()) {
    on<NumberTriviaEvent>((event, emit) async {
      if (event is GetRandomNumberTriviaEvent) {
        emit(Loading());

        final triviaOrFailure = await getRandomNumberTrivia(NoParams());

        triviaOrFailure.fold(
          (l) => emit(Error(errorMessage(l))),
          (r) => emit(Loaded(r)),
        );
      } else if (event is GetConcreteNumberTriviaEvent) {
        final inputEither = inputConverter.getIntFromString(event.numberString);

        await inputEither.fold(
          (l) async => emit(Error(errorMessage(l))),
          (r) async {
            emit(Loading());

            final triviaOrFailure =
                await getConcreteNumberTrivia(Params(number: r));

            triviaOrFailure.fold(
              (l) => emit(Error(errorMessage(l))),
              (trivia) => emit(Loaded(trivia)),
            );
          },
        );
      }
    });
  }

  String errorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return kServerFailureMessage;
      case InvalidInputFailure:
        return kInvalidInputErrorMessage;
      default:
        return kUnexpectedErrorMessage;
    }
  }
}
