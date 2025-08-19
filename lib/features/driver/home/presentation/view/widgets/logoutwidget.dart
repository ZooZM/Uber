import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uber/auth/data/models/user_strorge.dart';
import 'package:uber/constants.dart';
import 'package:uber/core/utils/app_router.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: IconButton(
          onPressed: () async {
            await UserStorage.deleteUserData();
            context.go(AppRouter.kSignIn);
          },
          icon: Icon(Icons.logout, size: 28, color: kOrange),
        ),
      ),
    );
  }
}
