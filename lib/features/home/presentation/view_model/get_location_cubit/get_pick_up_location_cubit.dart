import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/features/home/domain/entities/locationentity.dart';
import 'package:uber/features/home/domain/usecases/get_pick_up_location_use_case.dart';

part 'get_pick_up_location_state.dart';

class GetPickUpLocationCubit extends Cubit<GetPickUpLocationState> {
  GetPickUpLocationCubit(this.getPickUpLocationUseCase)
    : super(GetPickUpLocationInitial());
  final GetPickUpLocationUseCase getPickUpLocationUseCase;

  Future<void> getPickUpLocationCubit(LatLng latLng) async {
    emit(GetPickUpLocationLoading());
    var result = await getPickUpLocationUseCase.call(latLng);
    result.fold(
      (failure) {
        emit(GetPickUpLocationFailure(failure.failurMsg));
      },
      (data) {
        emit(GetPickUpLocationSuccess(data));
      },
    );
  }
}
