import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/score.dart';

class ResultRepo {
  final db = FirebaseFirestore.instance;

  ResultRepo();

  Future<QuerySnapshot<Object?>> getLastTenScores(
      String category, String diffLevel) async {
    final CollectionReference _scores =
        FirebaseFirestore.instance.collection('score');
    var future = await _scores.limit(10).get();
    log(future.toString());

    return future;
  }

  void saveScore(
    double score,
    int attempts,
    int wrongAttempts,
    int correctAttempts,
    String categoryTitle,
  ) async {
    final docRef = db.collection('score').doc();
    Score obj = Score(
      attempts,
      wrongAttempts,
      correctAttempts,
      FirebaseAuth.instance.currentUser!.uid,
      DateTime.now(),
      score.toStringAsFixed(2),
      categoryTitle,
      docRef.id,
    );
    return docRef.set(obj.toJson()).then(
        (value) => log("The Score saved successfully!"),
        onError: (e) => log("Error: The Score didn't save: $e"));
  }
}
