import 'package:word_trivia/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls http://numbersapi.com/{number}.
  /// Throws [ServiceException] for all error codes.
  Future<NumberTrivia> getConcreteNumberTrivia(int number);

  /// Calls http://numbersapi.com/random.
  /// Throws [ServiceException] for all error codes.
  Future<NumberTrivia> getRandomNumberTrivia();
}
