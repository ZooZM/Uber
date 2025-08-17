import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uber/core/errors/failures.dart';
import 'package:uber/core/models/captine_model.dart';
import 'package:uber/features/user/home/domain/entities/choose_tripe_type_entity.dart';
import 'package:uber/features/user/home/domain/entities/locationentity.dart';

abstract class HomeRepository {
  Future<Either<Failure, LocationEntity>> getPickUPLocation(LatLng latLng);
  Future<Either<Failure, LocationEntity>> getDropOffLocation(LatLng latLng);
  Future<Either<Failure, List<Location>>> chooseTypeTrip(
    ChooseTripTypeEntity chooseTripTypeEntity,
  );
  Future<Either<Failure, List<ChooseTripTypeEntity>>> confirmTrip(
    LatLng pickUp,
    LatLng dropOff,
  );
  Future<Either<Failure, CaptainModel>> findCaptain(
    ChooseTripTypeEntity vehicleType,
  );
  Future<Either<Failure, CaptainModel>> trackcaptainLocation(
    ChooseTripTypeEntity vehicleType,
  );
}
