import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/signupcubit/signup_cubit.dart';
import 'widgets/signup_form.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: const Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50),
                Text(
                  "Create Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3A4D6F),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Fill your information below or register\nwith your social account",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Color(0xFF99A8C2)),
                ),
                SizedBox(height: 16),
                SignupForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
