import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/constants.dart';
import 'package:uber/features/home/presentation/view_model/get_location_cubit/get_pick_up_location_cubit.dart';

class PositionedPickupWidget extends StatelessWidget {
  const PositionedPickupWidget({
    super.key,
    required this.hintText,
    required this.iconData,
    required this.onPressed,
  });
  final String hintText;
  final IconData iconData;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPickUpLocationCubit, GetPickUpLocationState>(
      builder: (context, state) {
        bool isVisible = state is GetPickUpLocationChoose;

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 800),
          bottom: isVisible ? MediaQuery.of(context).size.height - 100 : 100,
          left: 20,
          right: 20,
          curve: Curves.easeInOut,
          child: AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: onPressed,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Icon(iconData, color: Colors.grey[600]),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                hintText,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white, size: 32),
                    style: IconButton.styleFrom(
                      backgroundColor: kBlack,
                      shape: CircleBorder(),
                    ),
                    onPressed: () {
                      context.read<GetPickUpLocationCubit>().emit(
                        GetPickUpLocationCancelled(),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.check, color: Colors.white, size: 32),
                    style: IconButton.styleFrom(
                      backgroundColor: kBlack,
                      shape: CircleBorder(),
                    ),
                    onPressed: onPressed,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
