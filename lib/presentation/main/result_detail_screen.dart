import 'package:quiz_bloc/data/repositories/result_repo.dart';
import 'package:flutter/material.dart';
import 'package:fl_score_bar/fl_score_bar.dart';
import 'package:quiz_bloc/utility/category_detail_list.dart';

class ResultDetailScreen extends StatelessWidget {
  final double score;

  final int attempts;
  final int wrongAttempts;
  final int correctAttempts;
  final bool isSaved;

  final ResultRepo resultRepo = ResultRepo();

  ResultDetailScreen(
      {Key? key,
      required this.score,
      required this.attempts,
      required this.wrongAttempts,
      required this.correctAttempts,
      required this.isSaved})
      : super(key: key) {
    if (isSaved == false) {
      resultRepo.saveScore(
        score,
        attempts,
        wrongAttempts,
        correctAttempts,
        categoryDetailList[0].title,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: categoryDetailList[0].textColor),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${categoryDetailList[0].title}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            IconScoreBar(
              scoreIcon: Icons.star_rounded,
              iconColor: Colors.yellow,
              score: correctAttempts.toDouble(),
              maxScore: 3,
              readOnly: true,
            ),
            const SizedBox(height: 30),
            Text(
              'Attempts: ${attempts.toString()}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Wrong Attempts: ${wrongAttempts.toString()}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Correct Attempts: ${correctAttempts.toString()}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 0.3 * MediaQuery.of(context).size.width,
                height: 0.08 * MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(1, 3),
                      blurRadius: 0.7,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.check,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
