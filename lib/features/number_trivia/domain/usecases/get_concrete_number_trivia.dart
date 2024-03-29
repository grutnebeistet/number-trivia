import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:word_trivia/core/error/failures.dart';
import 'package:word_trivia/core/usecases/usecase.dart';
import 'package:word_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:word_trivia/features/number_trivia/domain/repositories/number_trivia_repositories.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia,Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;
  Params({@required this.number}) : super([number]);
}
