import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_v2/features/presentation/bloc/number_trivia_bloc.dart';

class TriviaControl extends StatelessWidget {
  const TriviaControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => dispatchRandomNumberTrivia(context),
          child: const Text('Get Random'),
        ),
      ],
    );
  }

  dispatchRandomNumberTrivia(BuildContext context) {
    BlocProvider.of<NumberTriviaBloc>(context).add(
      GetRandomNumberTriviaEvent(),
    );
  }
}
