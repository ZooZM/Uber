import 'dart:math';
import 'package:flutter/material.dart';

class RippleLoading extends StatefulWidget {
  final double size; // Size of the loading widget
  final Color color; // Color of the ripples

  const RippleLoading({
    super.key,
    this.size = 100.0,
    this.color = const Color(0xff19DC7C),
  });

  @override
  _RippleLoadingState createState() => _RippleLoadingState();
}

class _RippleLoadingState extends State<RippleLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.repeat();
        }
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: CustomPaint(
        painter: RipplePainter(_animation.value, widget.color),
      ),
    );
  }
}

class RipplePainter extends CustomPainter {
  final double animationValue;
  final Color color;

  RipplePainter(this.animationValue, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 3; i >= 0; i--) {
      _drawCircle(canvas, Rect.fromLTRB(0, 0, size.width, size.height),
          i + animationValue);
    }
  }

  void _drawCircle(Canvas canvas, Rect rect, double value) {
    Paint paint = Paint()
      ..color = color.withOpacity((1 - (value / 4)).clamp(0.0, 1.0));

    canvas.drawCircle(
      rect.center,
      sqrt((rect.width * 0.5 * rect.width * 0.5) * (value / 4)),
      paint,
    );
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) {
    return true;
  }
}
