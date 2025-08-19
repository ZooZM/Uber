part of 'go_online_cubit.dart';

sealed class GoOnlineState extends Equatable {
  const GoOnlineState();

  @override
  List<Object> get props => [];
}

final class GoOnlineInitial extends GoOnlineState {}

final class GoOnlineLoading extends GoOnlineState {}

final class GoOnlineSuccess extends GoOnlineState {}

final class GoOfflineSuccess extends GoOnlineState {}

final class GoOnlineFailure extends GoOnlineState {
  final String error;

  const GoOnlineFailure(this.error);

  @override
  List<Object> get props => [error];
}
