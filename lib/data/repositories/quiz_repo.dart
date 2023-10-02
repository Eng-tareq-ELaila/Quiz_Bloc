import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/questions.dart';

class QuizDataRepository {
  final String url;
  QuizDataRepository(this.url);

  Future<List<Question>?> getAllquestion() async {
    log('get All question ');

    try {
      QuerySnapshot<Map<String, dynamic>> allProductsSnapshot =
          await FirebaseFirestore.instance
              .collection('questions')
              .orderBy('index')
              .get();

      List<Question> allProducts = allProductsSnapshot.docs.map((e) {
        Map<String, dynamic> documentMap = e.data();

        Question question = Question.fromMap(documentMap);

        return question;
      }).toList();

      return allProducts;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
