import 'package:flutter/material.dart';
import 'package:uber/constants.dart';
import 'package:uber/core/widgets/custom_circular_progress.dart';

class OnlineButton extends StatefulWidget {
  const OnlineButton({super.key, required this.state});
  final String state;
  @override
  State<OnlineButton> createState() => _OnlineButtonState();
}

class _OnlineButtonState extends State<OnlineButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _borderAnimation = Tween<double>(
      begin: 0,
      end: 30,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.lightBlue[700],
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(color: Colors.black45, blurRadius: 20, spreadRadius: 5),
            ],
          ),
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 100),
          child: widget.state == 'loading'
              ? CustomCircularProgress(size: 60, color: kWhite)
              : AnimatedBuilder(
                  animation: _borderAnimation,
                  builder: (context, child) {
                    return Container(
                      width: 55 + _borderAnimation.value,
                      height: 55 + _borderAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(
                            alpha: 0.6 - (_borderAnimation.value / 20),
                          ),
                          width: 3,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "GO",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
