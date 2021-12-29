part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetRandomNumberTriviaEvent extends NumberTriviaEvent {}

class GetConcreteNumberTriviaEvent extends NumberTriviaEvent {
  final String numberString;

  const GetConcreteNumberTriviaEvent(this.numberString);
}
