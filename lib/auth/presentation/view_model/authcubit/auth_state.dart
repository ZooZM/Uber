part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final CurUser user;
  AuthSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

final class AuthResetPasswordSuccess extends AuthState {}

final class AuthProviderAccountFailure extends AuthState {
  final String email;
  AuthProviderAccountFailure(this.email);
}
