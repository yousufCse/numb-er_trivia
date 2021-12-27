import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_v2/features/presentation/bloc/number_trivia_bloc.dart';

class TriviaControl extends StatefulWidget {
  const TriviaControl({Key? key}) : super(key: key);

  @override
  State<TriviaControl> createState() => _TriviaControlState();
}

class _TriviaControlState extends State<TriviaControl> {
  late String inputSrc;

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Enter any number'),
              onChanged: (number) {
                inputSrc = number;
              },
              onSubmitted: (_) {
                dispatchConcreteNumberTrivia(context);
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }

  dispatchRandomNumberTrivia(BuildContext context) {
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetRandomNumberTriviaEvent());
    controller.clear();
  }

  dispatchConcreteNumberTrivia(BuildContext context) {
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetConcreteNumberTriviaEvent(inputSrc));
  }
}
