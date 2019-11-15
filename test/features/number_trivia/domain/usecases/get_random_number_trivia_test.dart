import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:word_trivia/core/usecases/usecase.dart';
import 'package:word_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:word_trivia/features/number_trivia/domain/repositories/number_trivia_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:word_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumTrivia = NumberTrivia(number: 1, text: 'test');
  test('should get trivia from the repo', () async {
    // arrange
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumTrivia));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tNumTrivia));
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
