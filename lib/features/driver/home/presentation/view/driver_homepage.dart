import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/features/driver/home/presentation/view/widgets/driver_map.dart';
import 'package:uber/features/driver/home/presentation/view/widgets/logoutwidget.dart';
import 'package:uber/features/driver/home/presentation/view/widgets/online_controller.dart';
import 'package:uber/features/driver/home/presentation/view_model/cubit/go_online_cubit.dart';

class DriverHomepage extends StatelessWidget {
  const DriverHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    final goOnlineState = context.watch<GoOnlineCubit>().state;

    return Scaffold(
      body: Stack(
        children: [
          DriverMap(),
          OnlineController(goOnlineState: goOnlineState),
          LogOutWidget(),
        ],
      ),
    );
  }
}
