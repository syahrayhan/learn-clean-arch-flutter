import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_cleanarc/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_cleanarc/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetConcreteNumberTrivia usecases;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecases = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: "test", number: 1);

  test(
    'should get trivia for the number from the repository',
    () async {
      //assert
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      //arrange
      final result = await usecases.call(const Params(number: tNumber));
      expect(result, const Right(tNumberTrivia));
      //act
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
