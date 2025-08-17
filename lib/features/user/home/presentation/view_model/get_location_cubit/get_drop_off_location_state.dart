part of 'get_drop_off_location_cubit.dart';

sealed class GetDropOffLocationState extends Equatable {
  const GetDropOffLocationState();

  @override
  List<Object> get props => [];
}

final class GetDropOffLocationInitial extends GetDropOffLocationState {}

final class GetDropOffLocationChoose extends GetDropOffLocationState {}

final class GetDropOffLocationCancelled extends GetDropOffLocationState {}

final class GetDropOffLocationLoading extends GetDropOffLocationState {}

final class GetDropOffLocationSuccess extends GetDropOffLocationState {
  final LocationEntity location;

  const GetDropOffLocationSuccess(this.location);

  @override
  List<Object> get props => [location];
}

final class GetDropOffLocationFailure extends GetDropOffLocationState {
  final String error;

  const GetDropOffLocationFailure(this.error);

  @override
  List<Object> get props => [error];
}
