import 'package:flutter/material.dart';
import 'package:uber/constants.dart';
import 'package:uber/features/driver/home/presentation/view/widgets/online_button.dart';
import 'package:uber/features/driver/home/presentation/view_model/cubit/go_online_cubit.dart';

class OnlineController extends StatefulWidget {
  const OnlineController({super.key, required this.goOnlineState});
  final GoOnlineState goOnlineState;

  @override
  State<OnlineController> createState() => _OnlineControllerState();
}

class _OnlineControllerState extends State<OnlineController> {
  late OnlineState onlineState;
  @override
  void initState() {
    super.initState();
    if (widget.goOnlineState is GoOnlineSuccess) {
      onlineState = OnlineState.online;
    } else if (widget.goOnlineState is GoOnlineLoading) {
      onlineState = OnlineState.loading;
    } else {
      onlineState = OnlineState.offline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 38),
      child: Align(alignment: Alignment.bottomCenter, child: OnlineButton()),
    );
  }
}
