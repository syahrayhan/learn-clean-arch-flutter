// ignore_for_file: constant_identifier_names, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_cleanarc/core/error/failures.dart';
import 'package:number_trivia_cleanarc/core/usecases/usecase.dart';
import 'package:number_trivia_cleanarc/core/util/input_converter.dart';
import 'package:number_trivia_cleanarc/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_cleanarc/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_cleanarc/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required GetConcreteNumberTrivia concreate,
    required GetRandomNumberTrivia random,
    required this.inputConverter,
  })  : getConcreteNumberTrivia = concreate,
        getRandomNumberTrivia = random,
        super(Empty()) {
    on<NumberTriviaEvent>((event, emit) async {
      if (event is GetTriviaForConcreteNumber) {
        emit(Empty());

        final inputEither =
            inputConverter.stringToUnsignedInteger(event.numberString);

        await inputEither.fold(
          (failure) {
            emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE));
          },
          (integer) async {
            emit(Loading());
            final failureOrTrivia = await getConcreteNumberTrivia(
              Params(number: integer),
            );
            failureOrTrivia.fold(
              (failure) {
                emit(Error(message: _mapFailureToMessage(failure)));
              },
              (trivia) {
                emit(Loaded(trivia: trivia));
              },
            );
          },
        );
      } else if (event is GetTriviaForRandomNumber) {
        emit(Empty());
        emit(Loading());

        final failureOrTrivia = await getRandomNumberTrivia(NoParams());

        failureOrTrivia.fold(
          (failure) {
            emit(Error(message: _mapFailureToMessage(failure)));
          },
          (trivia) {
            emit(Loaded(trivia: trivia));
          },
        );
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
