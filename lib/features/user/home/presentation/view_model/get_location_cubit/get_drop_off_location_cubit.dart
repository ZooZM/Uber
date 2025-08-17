import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/features/user/home/domain/entities/locationentity.dart';
import 'package:uber/features/user/home/domain/usecases/get_drop_off_location_use_case.dart';

part 'get_drop_off_location_state.dart';

class GetDropOffLocationCubit extends Cubit<GetDropOffLocationState> {
  GetDropOffLocationCubit(this.getDropOffLocationUseCase)
    : super(GetDropOffLocationInitial());
  final GetDropOffLocationUseCase getDropOffLocationUseCase;

  Future<void> getDropOffLocationCubit(LatLng latLng) async {
    emit(GetDropOffLocationLoading());
    var result = await getDropOffLocationUseCase.call(latLng);
    result.fold(
      (failure) {
        emit(GetDropOffLocationFailure(failure.failurMsg));
      },
      (data) {
        emit(GetDropOffLocationSuccess(data));
      },
    );
  }
}
