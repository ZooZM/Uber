import 'package:dartz/dartz.dart';
import 'package:uber/core/errors/failures.dart';

abstract class UseCase<Type> {
  Future<Either<Failure, Type>> call();
}
