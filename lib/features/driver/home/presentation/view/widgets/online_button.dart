import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/constants.dart';
import 'package:uber/core/widgets/custom_circular_progress.dart';
import 'package:uber/features/driver/home/presentation/view_model/cubit/go_online_cubit.dart';

class OnlineButton extends StatefulWidget {
  const OnlineButton({super.key});

  @override
  State<OnlineButton> createState() => _OnlineButtonState();
}

class _OnlineButtonState extends State<OnlineButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _borderAnimation;
  OnlineState onlineState = OnlineState.offline;
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
    return BlocListener<GoOnlineCubit, GoOnlineState>(
      listener: (context, state) {
        if (state is GoOnlineSuccess) {
          setState(() {
            onlineState = OnlineState.online;
          });
        } else if (state is GoOfflineSuccess) {
          setState(() {
            onlineState = OnlineState.offline;
          });
        } else if (state is GoOnlineLoading) {
          setState(() {
            onlineState = OnlineState.loading;
          });
        } else if (state is GoOnlineFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              duration: Duration(seconds: 5),
            ),
          );
          setState(() {
            onlineState = OnlineState.offline;
          });
        }
      },

      child: InkWell(
        onTap: () {
          if (onlineState != OnlineState.loading) {
            context.read<GoOnlineCubit>().goOnline(
              onlineState != OnlineState.online,
            );
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: !(onlineState == OnlineState.offline)
                    ? kOrange
                    : Colors.lightBlue[700],
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 100),
              child: onlineState == OnlineState.loading
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
                          child: Center(
                            child: !(onlineState == OnlineState.offline)
                                ? Icon(
                                    Icons.cancel_outlined,
                                    size: 50,
                                    color: ksecondryColor,
                                  )
                                : Text(
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
        ),
      ),
    );
  }
}
