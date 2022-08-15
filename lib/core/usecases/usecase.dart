import 'package:dartz/dartz.dart';
import 'package:number_trivia_cleanarc/core/error/failures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
