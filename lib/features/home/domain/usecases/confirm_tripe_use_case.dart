import 'package:dartz/dartz.dart';
import 'package:uber/core/errors/failures.dart';
import 'package:uber/core/models/tripe_model.dart';
import 'package:uber/core/usecases/use_case.dart';
import 'package:uber/features/home/domain/entities/choose_tripe_type_entity.dart';
import 'package:uber/features/home/domain/repositories/home_repository.dart';

class ConfirmTripUseCase
    implements UseCase<List<ChooseTripTypeEntity>, TripeModel> {
  final HomeRepository homeRepository;

  ConfirmTripUseCase(this.homeRepository);

  @override
  Future<Either<Failure, List<ChooseTripTypeEntity>>> call(
    TripeModel params,
  ) async {
    return await homeRepository.confirmTrip(params);
  }
}
