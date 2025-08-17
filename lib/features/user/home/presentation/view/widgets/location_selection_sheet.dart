import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/constants.dart';
import 'package:uber/core/widgets/custom_circular_progress.dart';
import 'package:uber/features/user/home/presentation/view_model/cubit/confirm_tripe_cubit.dart';
import 'package:uber/features/user/home/presentation/view_model/get_location_cubit/get_drop_off_location_cubit.dart';
import 'package:uber/features/user/home/presentation/view_model/get_location_cubit/get_pick_up_location_cubit.dart';

class LocationSelectionSheet extends StatelessWidget {
  const LocationSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      // minChildSize: 0.2,
      maxChildSize: 0.4,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              BlocBuilder<GetPickUpLocationCubit, GetPickUpLocationState>(
                builder: (context, state) {
                  String hintText = 'Pickup location';

                  if (state is GetPickUpLocationSuccess) {
                    hintText = state.location.name;
                  }

                  return _buildLocationField(
                    icon: Icons.my_location,
                    hint: hintText,
                    context: context,
                    onTap: () {
                      context.read<GetPickUpLocationCubit>().emit(
                        GetPickUpLocationChoose(),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 12),
              BlocBuilder<GetDropOffLocationCubit, GetDropOffLocationState>(
                builder: (context, state) {
                  String hintText = 'Destination';

                  if (state is GetDropOffLocationSuccess) {
                    hintText = state.location.name;
                  }

                  return _buildLocationField(
                    icon: Icons.location_on,
                    hint: hintText,
                    context: context,
                    onTap: () {
                      context.read<GetDropOffLocationCubit>().emit(
                        GetDropOffLocationChoose(),
                      );
                    },
                  );
                },
              ),

              SizedBox(height: 36),
              BlocBuilder<ConfirmTripeCubit, ConfirmTripeState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      final pickState = context
                          .read<GetPickUpLocationCubit>()
                          .state;
                      final dropState = context
                          .read<GetDropOffLocationCubit>()
                          .state;

                      if (pickState is GetPickUpLocationSuccess &&
                          dropState is GetDropOffLocationSuccess) {
                        LatLng pickUp = LatLng(
                          pickState.location.coordinates.lat!,
                          pickState.location.coordinates.lng!,
                        );
                        LatLng dropOff = LatLng(
                          dropState.location.coordinates.lat!,
                          dropState.location.coordinates.lng!,
                        );
                        context.read<ConfirmTripeCubit>().confirmTrip(
                          pickUp,
                          dropOff,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: kBlack,
                    ),
                    child: (state is ConfirmTripeLoading)
                        ? CustomCircularProgress(size: 15, color: kWhite)
                        : const Text(
                            'Confirm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLocationField({
    required IconData icon,
    required String hint,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.grey[600]),
            SizedBox(width: 12),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                hint,
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
