import 'package:dartz/dartz.dart';
import 'package:uber/core/errors/failures.dart';

abstract class DriverHomeRepo {
  Future<Either<Failure, void>> goOnline();
  Future<Either<Failure, void>> goOffline();
}
