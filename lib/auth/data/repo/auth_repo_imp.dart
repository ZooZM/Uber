import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/failures.dart';
import '../../../core/utils/api_service.dart';
import '../models/curuser.dart';
import '../models/user_strorge.dart';
import 'auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  final ApiService apiService;

  AuthRepoImp(this.apiService);
  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      final response = await apiService.post(
        endPoint: "auth/forgot-password",
        data: {'email': email},
      );

      if (response['success']) {
        // ignore: void_checks
        return Right(response['message'] ?? 'Reset code sent to your email');
      } else {
        return Left(
          Serverfailure(response['message'] ?? 'Failed to send reset code'),
        );
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        if (e.response!.data['error_code'] == "A4000") {
          return Left(Serverfailure("Please verify your email first."));
        } else {
          return Left(
            Serverfailure(
              e.response!.data['message'] ?? 'An error occurred during sign in',
            ),
          );
        }
      }
      return Left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CurUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        endPoint: '/api/v1/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response['status'] == 'success') {
        final userData = response['data'];
        CurUser user = CurUser.fromJson(userData['user']);
        user.token = response['token'];
        await UserStorage.saveUserData(
          token: user.token,
          userId: user.userId,
          name: user.name,
          email: user.email,
          photo: user.photo,
          phoneNumber: user.phoneNumber,
          role: user.role,
          nationalId: user.nationalId,
          vehicleType: user.vehicleType,
          coord: user.coord,
          online: user.online,
        );

        return Right(user);
      } else {
        return Left(Serverfailure('Failed to sign in'));
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        if (e.response!.data['error_code'] == "A4000") {
          return Left(Serverfailure("Please verify your email first."));
        } else {
          return Left(
            Serverfailure(
              e.response!.data['message'] ?? 'An error occurred during sign in',
            ),
          );
        }
      }
      return Left(Serverfailure(e.toString()));
    } catch (e) {
      print(e);
      return Left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUp({
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
    try {
      final response = await apiService.post(
        endPoint: 'auth/signup',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'passwordConfirm': confirmPassword,
          'region': region,
          'gender': gender,
          'age': age,
          'signUpPlatform': 'mobile',
          'role': role,
          'phoneNumber': phoneNumber,
          'type': type,
        },
      );

      if (response['success']) {
        final userData = response['data'];
        CurUser user = CurUser.fromJson(userData['user']);
        user.token = userData['token'];
        await UserStorage.saveUserData(
          token: user.token,
          userId: user.userId,
          name: user.name,
          email: user.email,
          photo: user.photo,
          phoneNumber: user.phoneNumber,
          role: user.role,
          nationalId: user.nationalId,
          vehicleType: user.vehicleType,
          coord: user.coord,
          online: user.online,
        );
        return Right(response['message']);
      } else {
        return Left(Serverfailure(response['message'] ?? 'Signup failed.'));
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred during sign up';
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        errorMessage = e.response!.data['message'] ?? errorMessage;
      }
      return Left(Serverfailure(errorMessage));
    }
  }

  @override
  Future<void> verifyEmail() {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CurUser>> fetchuser() async {
    try {
      final user = UserStorage.getUserData();
      final response = await apiService.get(
        endPoint: 'users/me',
        token: user.token,
      );

      if (response['success']) {
        final userData = response['data'];
        CurUser user = CurUser.fromJson(userData['user']);
        user.token = userData['token'];

        if (user.role != 'provider') {
          return Left(
            Serverfailure("You are not allowed to sign in as a non-provider."),
          );
        }

        try {
          final response = await apiService.get(
            endPoint: 'providers/${user.userId}',
          );
          if (response['success']) {
          } else {
            return Left(Serverfailure(user.email));
          }
        } catch (e) {
          return Left(Serverfailure('Failed to sign in'));
        }
        await UserStorage.saveUserData(
          token: user.token,
          userId: user.userId,
          name: user.name,
          email: user.email,
          photo: user.photo,
          phoneNumber: user.phoneNumber,
          role: user.role,
          nationalId: user.nationalId,
          vehicleType: user.vehicleType,
          coord: user.coord,
          online: user.online,
        );
        return Right(user);
      } else {
        return Left(Serverfailure('Failed to sign in'));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.statusCode == 401) {
          UserStorage.deleteUserData();
          return Left(Serverfailure('Unauthorized'));
        } else if (e.response != null) {
          return Left(Serverfailure(e.response!.data['message']));
        }
      }
      return Left(Serverfailure('Unknown error'));
    }
  }

  @override
  Future<Either<Failure, List<File>>> checkId(
    File frontImage,
    File backImage,
  ) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(frontImage.path),
        // 'backImage': await MultipartFile.fromFile(backImage.path),
      });
      // 'http://192.168.1.3:9000/predict'
      final response = await Dio().post(
        'http://192.168.1.3:9000/predict',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['status'] == 'real') {
          final listFiles = <File>[frontImage, backImage];

          return Right(listFiles);
        } else if (response.data['status'] == 'fake') {
          return Left(
            Serverfailure(
              response.data['process_results']['final_result'] ??
                  'Failed to check ID',
            ),
          );
        } else {
          return Left(Serverfailure('Unknown status from server'));
        }
      } else {
        return Left(
          Serverfailure(response.data['message'] ?? 'Failed to check ID'),
        );
      }
    } catch (e) {
      return Left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, File>> createFaceID({
    required File photo,
    required bool isSignUp,
  }) async {
    String errorMessage =
        'An error occurred during create face ID, please try again or take clear photo';
    String checkState = isSignUp ? 'signUp' : 'verify';
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(photo.path),
      });

      final response = await Dio().post(
        'http://192.168.1.3:7000/$checkState',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(photo);
      } else {
        return Left(Serverfailure(errorMessage));
      }
    } on DioException {
      return Left(Serverfailure(errorMessage));
    }
  }
}
