import 'package:flutter/material.dart';
import 'package:uber/constants.dart';
import 'package:uber/core/utils/styles.dart';

class TripType extends StatelessWidget {
  const TripType({
    super.key,
    required this.title,
    required this.subTitle,
    required this.nOfClient,
    required this.iconAssetsPath,
    required this.price,
    required this.durationByM,
    required this.isPressed,
  });
  final String title;
  final String subTitle;
  final String nOfClient;
  final String iconAssetsPath;
  final double price;
  final int durationByM;
  final bool isPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: kWhite,
          border: isPressed ? Border.all(color: kBlack, width: 3) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1.2,
                child: SizedBox(child: Image.asset(iconAssetsPath)),
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title == "VehicleType.car" ? "UberGo" : "Scooter",
                        style: Styles.subtitle18Bold,
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.person, size: 22),
                      Text(nOfClient),
                    ],
                  ),
                  Text("$durationByM min away", style: Styles.text16SemiBold),
                  Text(subTitle, style: Styles.text12Light),
                ],
              ),
              Spacer(),
              Text(
                "EGP ${price.toStringAsFixed(2)}",
                style: Styles.subtitle18Bold,
              ),
              SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
