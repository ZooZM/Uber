import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uber/core/models/tripe_model.dart';
import 'package:uber/features/home/domain/entities/choose_tripe_type_entity.dart';
import 'package:uber/features/home/domain/usecases/confirm_tripe_use_case.dart';

part 'confirm_tripe_state.dart';

class ConfirmTripeCubit extends Cubit<ConfirmTripeState> {
  ConfirmTripeCubit(this.confirmTripUseCase) : super(ConfirmTripeInitial());
  final ConfirmTripUseCase confirmTripUseCase;

  Future<void> confirmTrip(TripeModel trip) async {
    emit(ConfirmTripeLoading());
    var result = await confirmTripUseCase.call(trip);
    result.fold(
      (failure) {
        emit(ConfirmTripeFailure(failure.failurMsg));
      },
      (data) {
        emit(ConfirmTripeSuccess(data));
      },
    );
  }
}
