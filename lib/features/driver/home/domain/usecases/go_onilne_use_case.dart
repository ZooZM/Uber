import 'package:dartz/dartz.dart';
import 'package:uber/core/errors/failures.dart';
import 'package:uber/core/usecases/use_case.dart';
import 'package:uber/features/driver/home/domain/repositories/driver_home_repo.dart';

class GoOnilneUseCase implements UseCase<void, bool> {
  final DriverHomeRepo driverHomeRepoImpl;

  GoOnilneUseCase(this.driverHomeRepoImpl);

  @override
  Future<Either<Failure, void>> call(bool isOnilne) {
    if (isOnilne) {
      return driverHomeRepoImpl.goOnline();
    } else {
      return driverHomeRepoImpl.goOffline();
    }
  }
}
