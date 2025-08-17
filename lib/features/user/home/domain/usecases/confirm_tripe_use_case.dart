import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/core/errors/failures.dart';
import 'package:uber/core/usecases/use_case.dart';
import 'package:uber/features/user/home/domain/entities/choose_tripe_type_entity.dart';
import 'package:uber/features/user/home/domain/repositories/home_repository.dart';

class ConfirmTripUseCaseParams {
  final LatLng pickUp;
  final LatLng dropOff;

  ConfirmTripUseCaseParams({required this.pickUp, required this.dropOff});
}

class ConfirmTripUseCase
    implements UseCase<List<ChooseTripTypeEntity>, ConfirmTripUseCaseParams> {
  final HomeRepository homeRepository;

  ConfirmTripUseCase(this.homeRepository);

  @override
  Future<Either<Failure, List<ChooseTripTypeEntity>>> call(
    ConfirmTripUseCaseParams params,
  ) async {
    return await homeRepository.confirmTrip(params.pickUp, params.dropOff);
  }
}
