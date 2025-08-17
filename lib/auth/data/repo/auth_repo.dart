import 'dart:ffi';
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../models/curuser.dart';

abstract class AuthRepo {
  Future<Either<Failure, CurUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

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
  });

  Future<void> signOut();

  Future<Either<Failure, void>> resetPassword({required String email});

  Future<void> verifyEmail();

  Future<Either<Failure, CurUser>> fetchuser();

  Future<Either<Failure, List<File>>> checkId(File frontImage, File backImage);

  Future<Either<Failure, File>> createFaceID({
    required File photo,
    required bool isSignUp,
  });
}
