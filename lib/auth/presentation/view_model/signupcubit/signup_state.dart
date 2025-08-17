part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String email;

  SignupSuccess(this.email);

  @override
  List<Object?> get props => [email];
}

class SignupFailure extends SignupState {
  final String errorMessage;

  SignupFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
