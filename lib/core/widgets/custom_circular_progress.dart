import 'package:flutter/material.dart';
import 'package:uber/constants.dart';

class CustomCircularProgress extends StatefulWidget {
  const CustomCircularProgress({
    super.key,
    required this.size,
    this.color = ksecondryColor,
  });

  final double size;
  final Color color;

  @override
  State<CustomCircularProgress> createState() => _CustomCircularProgressState();
}

class _CustomCircularProgressState extends State<CustomCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: widget.color,
      end: Colors.blueAccent,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: CircularProgressIndicator(
        strokeWidth: 4,
        valueColor: _colorAnimation,
      ),
    );
  }
}
