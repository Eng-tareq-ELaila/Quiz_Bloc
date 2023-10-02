import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quiz_bloc/bloc/quiz_data/quiz_data_bloc.dart';
import 'package:quiz_bloc/bloc/quiz_data/quiz_data_event.dart';
import 'package:quiz_bloc/presentation/main/question_screen.dart';
import 'package:quiz_bloc/utility/category_detail_list.dart';

import '../../bloc/quiz_data/quiz_data_state.dart';
import '../../data/repositories/quiz_repo.dart';

class PrepareQuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => QuizDataRepository(''),
        child: BlocProvider(
            create: (context) => QuizDataBloc(
                  repository:
                      RepositoryProvider.of<QuizDataRepository>(context),
                )..add(DataRequested()),
            child: Container(
                decoration: BoxDecoration(
                  color: categoryDetailList[0].textColor,
                ),
                child: BlocListener<QuizDataBloc, QuizDataState>(
                  listener: (context, state) {
                    if (state is Success) {
                      // Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: ((context) =>
                              QuestionsScreen(questionData: state.data)),
                        ),
                      );
                    }
                    if (state is Error) {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: const Text('Error'),
                                content: Text(state.error),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              ));
                    }
                  },
                  child: BlocBuilder<QuizDataBloc, QuizDataState>(
                      builder: (context, state) {
                    // state is loading
                    return Scaffold(
                      // backgroundColor: Colors.transparent,
                      body: Center(
                        child: LoadingAnimationWidget.discreteCircle(
                          color: Colors.orangeAccent,
                          size: 50,
                        ),
                      ),
                    );
                  }),
                ))));
  }
}
