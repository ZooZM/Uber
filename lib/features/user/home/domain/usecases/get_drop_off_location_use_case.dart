import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/core/errors/failures.dart';
import 'package:uber/features/user/home/domain/entities/locationentity.dart';
import 'package:uber/features/user/home/domain/repositories/home_repository.dart';

import '../../../../../core/usecases/use_case.dart';

class GetDropOffLocationUseCase extends UseCase<LocationEntity, LatLng> {
  final HomeRepository repository;

  GetDropOffLocationUseCase(this.repository);

  @override
  Future<Either<Failure, LocationEntity>> call(LatLng params) async {
    return await repository.getDropOffLocation(params);
  }
}
