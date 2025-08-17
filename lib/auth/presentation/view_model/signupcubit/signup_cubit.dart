import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/api_service.dart';
import '../../../data/repo/auth_repo_imp.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final authRepo = AuthRepoImp(ApiService(Dio()));

  SignupCubit() : super(SignupInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String region,
    required String gender,
    required String age,
    required String role,
    required String phoneNumber,
    required String type,
  }) async {
    emit(SignupLoading());
    try {
      final response = await authRepo.signUp(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        region: region,
        gender: gender,
        age: age,
        role: role,
        phoneNumber: phoneNumber,
        type: type,
      );

      response.fold(
        (failure) {
          emit(SignupFailure(failure.failurMsg));
        },
        (_) {
          emit(SignupSuccess(email));
        },
      );
    } catch (e) {
      emit(SignupFailure('An unexpected error occurred.'));
    }
  }
}
