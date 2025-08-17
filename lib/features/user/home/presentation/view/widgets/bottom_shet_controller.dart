import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/features/user/home/presentation/view/widgets/choose_trip_type.dart';
import 'package:uber/features/user/home/presentation/view/widgets/location_selection_sheet.dart';
import 'package:uber/features/user/home/presentation/view_model/cubit/confirm_tripe_cubit.dart';
import 'package:uber/features/user/home/presentation/view_model/get_location_cubit/get_drop_off_location_cubit.dart';
import 'package:uber/features/user/home/presentation/view_model/get_location_cubit/get_pick_up_location_cubit.dart';

class BottomSheetController extends StatelessWidget {
  const BottomSheetController({super.key});

  @override
  Widget build(BuildContext context) {
    final pickState = context.watch<GetPickUpLocationCubit>().state;
    final dropState = context.watch<GetDropOffLocationCubit>().state;
    bool confirmTripState =
        context.watch<ConfirmTripeCubit>().state is ConfirmTripeSuccess;
    final bool showBottomSheet =
        !(pickState is GetPickUpLocationChoose ||
            dropState is GetDropOffLocationChoose);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      child: confirmTripState
          ? ChooseTripType()
          : showBottomSheet
          ? const Align(
              alignment: Alignment.bottomCenter,
              child: LocationSelectionSheet(),
            )
          : const SizedBox.shrink(),
    );
  }
}
