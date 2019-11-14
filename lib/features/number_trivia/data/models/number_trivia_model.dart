import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:word_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({
    @required String txt,
    @required int num,
  }) : super(txt: txt, num: num);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    // casting as num succeeds with all number types
    return NumberTriviaModel(
        txt: json['text'], num: (json['number'] as num).toInt());
  }

  Map<String, dynamic> toJson() {
    return {
      'text': txt,
      'number': num,
    };
  }
}
