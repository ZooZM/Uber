import 'package:flutter/material.dart';
import 'package:uber/constants.dart';

class CustomCircularprogress extends StatelessWidget {
  const CustomCircularprogress({
    super.key,
    required this.size,
    this.color = ksecondryColor,
  });
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(color: color),
    );
  }
}
