import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onPressed,
  });
  final String text, buttonText;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(color: Color(0xFF99A8C2)),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Color(0xFF3A4D6F),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
