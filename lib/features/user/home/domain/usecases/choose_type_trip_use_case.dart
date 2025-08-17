import 'package:dartz/dartz.dart';
import 'package:location/location.dart';
import 'package:uber/core/errors/failures.dart';
import 'package:uber/core/usecases/use_case.dart';
import 'package:uber/features/user/home/domain/entities/choose_tripe_type_entity.dart';
import 'package:uber/features/user/home/domain/repositories/home_repository.dart';

class ChooseTypeTripUseCase
    implements UseCase<List<Location>, ChooseTripTypeEntity> {
  final HomeRepository homeRepository;
  ChooseTypeTripUseCase(this.homeRepository);
  @override
  Future<Either<Failure, List<Location>>> call(
    ChooseTripTypeEntity params,
  ) async {
    return await homeRepository.chooseTypeTrip(params);
  }
}
