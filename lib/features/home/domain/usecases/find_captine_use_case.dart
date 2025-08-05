import 'package:dartz/dartz.dart';
import 'package:uber/core/errors/failures.dart';
import 'package:uber/features/home/domain/entities/choose_tripe_type_entity.dart';
import 'package:uber/features/home/domain/repositories/home_repository.dart';

import '../../../../core/models/captine_model.dart';
import '../../../../core/usecases/use_case.dart';

class FindCaptainUseCase
    implements UseCase<CaptainModel, ChooseTripTypeEntity> {
  final HomeRepository homeRepository;

  FindCaptainUseCase(this.homeRepository);

  @override
  Future<Either<Failure, CaptainModel>> call(
    ChooseTripTypeEntity params,
  ) async {
    return await homeRepository.findCaptain(params);
  }
}
