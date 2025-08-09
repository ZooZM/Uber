part of 'confirm_tripe_cubit.dart';

sealed class ConfirmTripeState extends Equatable {
  const ConfirmTripeState();

  @override
  List<Object> get props => [];
}

final class ConfirmTripeInitial extends ConfirmTripeState {}

final class ConfirmTripeLoading extends ConfirmTripeState {}

final class ConfirmTripeSuccess extends ConfirmTripeState {
  final List<ChooseTripTypeEntity> tripTypes;

  const ConfirmTripeSuccess(this.tripTypes);

  @override
  List<Object> get props => [tripTypes];
}

final class ConfirmTripeFailure extends ConfirmTripeState {
  final String error;

  const ConfirmTripeFailure(this.error);
  @override
  List<Object> get props => [error];
}
