import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../data/model/questions.dart';

@immutable
abstract class QuizDataState extends Equatable {}

class Loading extends QuizDataState {
  @override
  List<Object?> get props => [];
}

class Success extends QuizDataState {
  List<Question>? data;

  Success(this.data);

  @override
  List<Object?> get props => [];
}

class Error extends QuizDataState {
  final String error;

  Error(this.error);
  @override
  List<Object?> get props => [error];
}
