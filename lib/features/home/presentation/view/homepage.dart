import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/constants.dart';
import 'package:uber/features/home/presentation/view/widgets/bottom_shet_controller.dart';
import 'package:uber/features/home/presentation/view/widgets/map.dart';
import 'package:uber/features/home/presentation/view/widgets/positioned_Pickup_widget.dart';
import 'package:uber/features/home/presentation/view/widgets/positioned_destination_widget.dart';
import 'package:uber/features/home/presentation/view_model/cubit/get_drop_off_location_cubit.dart';
import 'package:uber/features/home/presentation/view_model/cubit/get_pick_up_location_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pickState = context.watch<GetPickUpLocationCubit>().state;
    final dropState = context.watch<GetDropOffLocationCubit>().state;
    LatLng? centerLatLng;
    return Scaffold(
      body: Stack(
        children: [
          BackgroundMap(onCenterChanged: (center) => centerLatLng = center),
          if (dropState is GetDropOffLocationChoose ||
              pickState is GetPickUpLocationChoose)
            Align(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: const Offset(0, -27),
                child: Icon(Icons.location_on, color: kBlack, size: 54),
              ),
            ),

          PositionedPickupWidget(
            hintText: 'Pickup location',
            iconData: Icons.my_location,
            onPressed: () {
              if (centerLatLng != null) {
                context.read<GetPickUpLocationCubit>().getPickUpLocationCubit(
                  centerLatLng!,
                );
              }
            },
          ),
          PositionedDestinationWidget(
            hintText: 'Destination',
            iconData: Icons.location_on,
            onPressed: () {
              if (centerLatLng != null) {
                context.read<GetDropOffLocationCubit>().getDropOffLocationCubit(
                  centerLatLng!,
                );
              }
            },
          ),
          const BottomSheetController(),
        ],
      ),
    );
  }
}
