import 'package:flutter/material.dart';
import 'package:uber/features/driver/home/presentation/view/widgets/driver_map.dart';
import 'package:uber/features/driver/home/presentation/view/widgets/online_button.dart';

class DriverHomepage extends StatelessWidget {
  const DriverHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DriverMap(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 38),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: OnlineButton(state: 'loading'),
            ),
          ),
        ],
      ),
    );
  }
}
