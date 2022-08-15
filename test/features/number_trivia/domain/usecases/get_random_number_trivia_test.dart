import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_cleanarc/core/usecases/usecase.dart';
import 'package:number_trivia_cleanarc/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_cleanarc/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumberTrivia = NumberTrivia(number: 1, text: "test");

  test(
    'should get random trivia from repository',
    () async {
      //assert
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => const Right(tNumberTrivia));
      //arrange
      final result = await usecase.call(NoParams());
      //act
      expect(result, const Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
