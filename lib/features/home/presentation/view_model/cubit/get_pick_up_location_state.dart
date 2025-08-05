part of 'get_pick_up_location_cubit.dart';

sealed class GetPickUpLocationState extends Equatable {
  const GetPickUpLocationState();

  @override
  List<Object> get props => [];
}

final class GetPickUpLocationInitial extends GetPickUpLocationState {}

final class GetPickUpLocationChoose extends GetPickUpLocationState {}

final class GetPickUpLocationCancelled extends GetPickUpLocationState {}

final class GetPickUpLocationLoading extends GetPickUpLocationState {}

final class GetPickUpLocationSuccess extends GetPickUpLocationState {
  final LocationEntity location;

  const GetPickUpLocationSuccess(this.location);

  @override
  List<Object> get props => [location];
}

final class GetPickUpLocationFailure extends GetPickUpLocationState {
  final String error;

  const GetPickUpLocationFailure(this.error);

  @override
  List<Object> get props => [error];
}
