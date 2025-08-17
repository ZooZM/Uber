import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/features/user/home/domain/entities/choose_tripe_type_entity.dart';
import 'package:uber/features/user/home/domain/usecases/confirm_tripe_use_case.dart';

part 'confirm_tripe_state.dart';

class ConfirmTripeCubit extends Cubit<ConfirmTripeState> {
  ConfirmTripeCubit(this.confirmTripUseCase) : super(ConfirmTripeInitial());
  final ConfirmTripUseCase confirmTripUseCase;

  Future<void> confirmTrip(LatLng pickUp, LatLng dropOff) async {
    emit(ConfirmTripeLoading());
    var result = await confirmTripUseCase.call(
      ConfirmTripUseCaseParams(pickUp: pickUp, dropOff: dropOff),
    );
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
