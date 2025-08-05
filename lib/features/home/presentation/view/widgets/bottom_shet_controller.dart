import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/features/home/presentation/view/widgets/location_selection_sheet.dart';
import 'package:uber/features/home/presentation/view_model/cubit/get_drop_off_location_cubit.dart';
import 'package:uber/features/home/presentation/view_model/cubit/get_pick_up_location_cubit.dart';

class BottomSheetController extends StatelessWidget {
  const BottomSheetController({super.key});

  @override
  Widget build(BuildContext context) {
    final pickState = context.watch<GetPickUpLocationCubit>().state;
    final dropState = context.watch<GetDropOffLocationCubit>().state;

    final bool showBottomSheet =
        !(pickState is GetPickUpLocationChoose ||
            dropState is GetDropOffLocationChoose);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      child: showBottomSheet
          ? const Align(
              alignment: Alignment.bottomCenter,
              child: LocationSelectionSheet(),
            )
          : const SizedBox.shrink(),
    );
  }
}
