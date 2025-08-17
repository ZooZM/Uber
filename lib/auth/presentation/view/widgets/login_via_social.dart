import 'package:flutter/material.dart';

class LoginViaSocial extends StatelessWidget {
  const LoginViaSocial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Handle Google Sign-Up
          },
          child: Image.asset(
            "assets/icons/google.png.jpeg",
            height: 55,
            width: 55,
          ),
        ),
        const SizedBox(width: 32),
        GestureDetector(
          onTap: () {
            // Handle Facebook Sign-Up
          },
          child: Image.asset(
            "assets/icons/facebook.png.webp",
            height: 70,
            width: 70,
          ),
        ),
        const SizedBox(width: 32),
        GestureDetector(
          onTap: () {
            // Handle Apple Sign-Up
          },
          child: Image.asset(
            "assets/icons/apple.png.jpeg",
            height: 65,
            width: 60,
          ),
        ),
      ],
    );
  }
}
