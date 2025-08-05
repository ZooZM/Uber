import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:location/location.dart';
import 'package:uber/core/errors/failures.dart';
import 'package:uber/core/models/captine_model.dart';
import 'package:uber/core/utils/api_service.dart';
import 'package:uber/features/home/data/datasources/home_remote_data_source.dart';
import 'package:uber/features/home/domain/entities/choose_tripe_type_entity.dart';
import 'package:uber/features/home/domain/entities/locationentity.dart';
import 'package:uber/features/home/domain/entities/tripe_entity.dart';
import 'package:uber/features/home/domain/repositories/home_repository.dart';

class HomeRepoImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepoImpl(this.homeRemoteDataSource);
  @override
  Future<Either<Failure, List<Location>>> chooseTypeTrip(
    ChooseTripTypeEntity chooseTripTypeEntity,
  ) {
    // TODO: implement chooseTypeTrip
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ChooseTripTypeEntity>>> confirmTrip(
    TripeModel tripEntity,
  ) {
    // TODO: implement confirmTrip
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CaptainModel>> findCaptain(
    ChooseTripTypeEntity vehicleType,
  ) {
    // TODO: implement findCaptain
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CaptainModel>> trackcaptainLocation(
    ChooseTripTypeEntity vehicleType,
  ) {
    // TODO: implement trackcaptainLocation
    throw UnimplementedError();
  }

  String cleanAddressName(String fullName) {
    List<String> parts = fullName.split(',');

    if (parts.length >= 2) {
      return '${parts[1].trim()}, ${parts[2].trim()}, ${parts[3].trim()}';
    }

    // fallback
    return fullName;
  }

  @override
  Future<Either<Failure, LocationEntity>> getDropOffLocation(
    LatLng latLng,
  ) async {
    try {
      final response = await homeRemoteDataSource.getDropOffLocation(latLng);
      final cleanedName = cleanAddressName(response.name);
      return Right(response.copyWith(name: cleanedName));
    } catch (e) {
      if (e is DioException) {
        return left(Serverfailure.fromDioException(e));
      }
      return left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> getPickUPLocation(
    LatLng latLng,
  ) async {
    try {
      final response = await homeRemoteDataSource.getPickUPLocation(latLng);
      final cleanedName = cleanAddressName(response.name);
      return Right(response.copyWith(name: cleanedName));
    } catch (e) {
      if (e is DioException) {
        return left(Serverfailure.fromDioException(e));
      }
      return left(Serverfailure(e.toString()));
    }
  }
}
