import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackButtonCircle extends StatelessWidget {
  const BackButtonCircle({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/');
          }
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFF99A8C2)),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFF3A4D6F),
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
