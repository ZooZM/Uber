import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/core/errors/failures.dart';
import 'package:uber/core/usecases/use_case.dart';
import 'package:uber/features/user/home/domain/entities/locationentity.dart';
import 'package:uber/features/user/home/domain/repositories/home_repository.dart';

class GetPickUpLocationUseCase implements UseCase<LocationEntity, LatLng> {
  final HomeRepository homeRepository;
  GetPickUpLocationUseCase(this.homeRepository);

  @override
  Future<Either<Failure, LocationEntity>> call(LatLng params) async {
    return await homeRepository.getPickUPLocation(params);
  }
}
