import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uber/constants.dart';

class LocationArrow extends StatelessWidget {
  const LocationArrow({super.key, required this.onPressed});
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: kWhite,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FontAwesomeIcons.locationArrow,
                color: ksecondryColor,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
