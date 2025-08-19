import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:uber/auth/data/models/user_strorge.dart';
import 'package:uber/core/errors/failures.dart';
import 'package:uber/features/driver/home/data/datasources/driver_home_remote_data_source.dart';
import 'package:uber/features/driver/home/data/repositories/socket_service.dart';
import 'package:uber/features/driver/home/domain/repositories/driver_home_repo.dart';

class DriverHomeRepoImpl implements DriverHomeRepo {
  final SocketService socketService;
  final DriverHomeRemoteDataSourceImpl driverHomeRemoteDataSourceImpl;
  DriverHomeRepoImpl(this.socketService, this.driverHomeRemoteDataSourceImpl);

  @override
  Future<Either<Failure, void>> goOffline() async {
    try {
      final user = UserStorage.getUserData();

      socketService.goOffline(user.userId);
      socketService.disconnect();
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return left(Serverfailure.fromDioException(e));
      }
      return left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> goOnline() async {
    try {
      final user = UserStorage.getUserData();

      socketService.connect();
      socketService.registerDriver(user.userId, user.coord, user.vehicleType!);
      socketService.goOnline(
        user.userId,
        user.coord[0],
        user.coord[1],
        user.vehicleType!,
      );

      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return left(Serverfailure.fromDioException(e));
      }
      return left(Serverfailure(e.toString()));
    }
  }
}
