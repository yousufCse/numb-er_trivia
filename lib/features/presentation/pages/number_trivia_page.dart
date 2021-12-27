import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_v2/features/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia_v2/features/presentation/wigets/display_error.dart';
import 'package:number_trivia_v2/features/presentation/wigets/display_trivia.dart';
import 'package:number_trivia_v2/features/presentation/wigets/trivia_control.dart';
import 'package:number_trivia_v2/features/presentation/wigets/welcome_text.dart';
import 'package:number_trivia_v2/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Number Trivia"),
        ),
        body: buildBody());
  }

  BlocProvider<NumberTriviaBloc> buildBody() {
    return BlocProvider<NumberTriviaBloc>(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            const WelcomeText(),
            const SizedBox(height: 30.0),
            buildBlocBuilder(),
            const Spacer(),
            TriviaControl(),
            const Spacer()
          ],
        ),
      ),
    );
  }

  BlocBuilder buildBlocBuilder() {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
      builder: (context, state) {
        if (state is NumberTriviaInitial) {
          return const Text('Start Searching');
        } else if (state is Loading) {
          return CircularProgressIndicator(color: Colors.green[400]);
        } else if (state is Error) {
          return DisplayError(text: state.message);
        } else if (state is Loaded) {
          return DisplayTrivia(trivia: state.numberTrivia);
        }
        return Container();
      },
    );
  }
}
