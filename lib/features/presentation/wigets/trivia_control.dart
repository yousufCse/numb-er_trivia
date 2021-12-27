import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_v2/features/presentation/bloc/number_trivia_bloc.dart';

class TriviaControl extends StatelessWidget {
  const TriviaControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: TextField(
            decoration: InputDecoration(hintText: 'Enter any number'),
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => dispatchRandomNumberTrivia(context),
              child: const Text('Get Random Trivia'),
            ),
            TextButton(
              onPressed: () => dispatchConcreteNumberTrivia(context),
              child: const Text('Get Concrete Trivia'),
            ),
          ],
        )
      ],
    );
  }

  dispatchRandomNumberTrivia(BuildContext context) {
    BlocProvider.of<NumberTriviaBloc>(context).add(
      GetRandomNumberTriviaEvent(),
    );
  }

  dispatchConcreteNumberTrivia(BuildContext context) {
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetConcreteNumberTriviaEvent());
  }
}
