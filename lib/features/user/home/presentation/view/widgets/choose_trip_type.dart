import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/features/user/home/presentation/view/widgets/trip_type.dart';
import 'package:uber/features/user/home/presentation/view_model/cubit/confirm_tripe_cubit.dart';

List<bool> isPressed = [true, false];

class ChooseTripType extends StatefulWidget {
  const ChooseTripType({super.key});

  @override
  State<ChooseTripType> createState() => _ChooseTripTypeState();
}

class _ChooseTripTypeState extends State<ChooseTripType> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmTripeCubit, ConfirmTripeState>(
      builder: (context, state) {
        if (state is ConfirmTripeSuccess) {
          return DraggableScrollableSheet(
            initialChildSize: 0.38,
            minChildSize: 0.3,
            maxChildSize: 0.45,
            builder: (context, scrollController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<ConfirmTripeCubit>().emit(
                        ConfirmTripeCancelled(),
                      );
                    },
                    icon: Icon(Icons.cancel, size: 34),
                  ),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                for (int i = 0; i < isPressed.length; i++) {
                                  isPressed[i] = i == index;
                                }
                              });
                            },
                            child: TripType(
                              title: state.tripTypes[index].name.toString(),
                              subTitle: state.tripTypes[index].description,
                              nOfClient: state.tripTypes[index].numOfPerson
                                  .toString(),
                              iconAssetsPath: state.tripTypes[index].assetsIcon,
                              price: state.tripTypes[index].price,
                              durationByM: state.tripTypes[index].durationInM,
                              isPressed: isPressed[index],
                            ),
                          ),
                        ),
                        itemCount: state.tripTypes.length,
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
