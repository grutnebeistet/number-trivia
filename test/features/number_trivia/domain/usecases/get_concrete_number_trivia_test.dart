import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:word_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:word_trivia/features/number_trivia/domain/repositories/number_trivia_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:word_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final tNum = 1;
  final tNumTrivia = NumberTrivia(number: tNum, text: 'test');
  test('should get trivia for the number from the repo', () async {
    // arrange
    // when getConcreteNumberTrivia is called with any number,
    // then answer with the Right of Either (non-failure)
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => Right(tNumTrivia));
    // act
    final result = await usecase(Params(number: tNum));
    // assert
    expect(result, Right(tNumTrivia));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNum));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
