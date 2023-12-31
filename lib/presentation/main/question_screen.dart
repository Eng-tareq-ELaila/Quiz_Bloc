import 'dart:developer';

import 'package:quiz_bloc/bloc/quiz/quiz_state.dart';
import 'package:quiz_bloc/presentation/main/result_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:quiz_bloc/utility/prepare_quiz.dart';
import 'package:quiz_bloc/utility/category_detail_list.dart';
import 'package:quiz_bloc/widgets/close_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/quiz/quiz_bloc.dart';
import '../../bloc/quiz/quiz_event.dart';
import '../../data/model/questions.dart';
import '../../widgets/option_widget.dart';

class QuestionsScreen extends StatefulWidget {
  QuestionsScreen({
    Key? key,
    required this.questionData,
  }) : super(key: key);

  final List<Question>? questionData;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  void initState() {
    super.initState();
    log(widget.questionData![0].toString());
    quizMaker.populateList(widget.questionData);
  }

  PrepareQuiz quizMaker = PrepareQuiz();
  int questionNumber = 0;

  bool isAbsorbing = false;

  final int duration = 10;

  List<Color> optionColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];

  int selectedOption = 0;

  List<Widget> buildOptions(List<String> options) {
    // List<String> options = quizMaker.getOptions(i);

    List<Widget> Options = [];

    for (int j = 0; j < 4; j++) {
      Options.add(OptionWidget(
        widget: widget,
        option: options[j],
        optionColor: optionColor[j],
        onTap: () async {
          setState(() {
            if (selectedOption != -1) {
              optionColor[selectedOption] = Colors.white;
            }
            selectedOption = j;
            optionColor[selectedOption] = Colors.greenAccent;
          });
          // await Future.delayed(const Duration(seconds: 1, milliseconds: 30), () {});
        },
      ));
    }
    return Options;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => QuizBloc(quizMaker),
        child: BlocListener<QuizBloc, QuizState>(
          listener: (context, state) {
            if (state is QuizFinishedState) {
              _navigateToResultScreen(context, state);
            }
          },
          child: BlocBuilder<QuizBloc, QuizState>(
            buildWhen: (previous, current) => true,
            builder: (BuildContext context, state) {
              if (state is QuizOnGoingState) {
                return AbsorbPointer(
                  absorbing: isAbsorbing,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 60, bottom: 20),
                    decoration: BoxDecoration(
                      color: categoryDetailList[0].textColor,
                    ),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              RoundCloseButton(),
                            ],
                          ),
                          // ignore: prefer_const_constructors
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${(state.currentIndex + 1).toString()} of ${widget.questionData?.length}',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.currentQuestion,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ...buildOptions(state.options),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (state.currentIndex <
                                      (widget.questionData?.length ?? 0) - 1) {
                                    if (selectedOption != -1)
                                      optionColor[selectedOption] =
                                          Colors.white;
                                    int selectedIndex = selectedOption;
                                    selectedOption = -1;
                                    BlocProvider.of<QuizBloc>(context)
                                        .add(NextQuestion(selectedIndex));
                                  } else {
                                    BlocProvider.of<QuizBloc>(context)
                                        .add(QuizFinished(selectedOption));
                                  }
                                },
                                child: const Text('Next'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  minimumSize:
                                      const Size(100, 40), //////// HERE
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Text('Loading...');
            },
          ),
        ));
  }

  void _navigateToResultScreen(context, QuizState state) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultDetailScreen(
          score: state.currentScore,
          attempts: state.currentAttempts,
          wrongAttempts: state.currentWrongAttempts,
          correctAttempts: state.currentCorrectAttempts,
          isSaved: false,
        ),
      ),
    );
  }
}
