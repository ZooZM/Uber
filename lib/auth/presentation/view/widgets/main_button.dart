import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../core/widgets/custom_circular_progress.dart';

class MainButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  const MainButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MaterialButton(
        onPressed: onPressed,
        height: 60,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: isLoading ? kGray : const Color(0xFF3A4D6F),
        elevation: 4,
        child: isLoading
            ? const CustomCircularProgress(size: 25)
            : Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
