import 'package:flutter/material.dart';
import 'package:uber/core/utils/styles.dart';

class CustomFailureMessage extends StatelessWidget {
  const CustomFailureMessage({super.key, required this.mess});
  final String mess;
  @override
  Widget build(BuildContext context) {
    return Text(mess, style: Styles.subtitle18Bold, softWrap: true);
  }
}
