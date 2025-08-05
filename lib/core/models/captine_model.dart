import 'package:location/location.dart';
import 'package:uber/constants.dart';

class CaptainModel {
  final String name;
  final VehicleType vehicleType;
  final String assetsImage;
  final String vehicleAssetsIcon;
  final String vehicleNumber;
  final String vehicleColor;
  final String vehicleModel;
  final String vehicleBrand;
  final double rating;
  final Location location;

  CaptainModel({
    required this.name,
    required this.vehicleType,
    required this.assetsImage,
    required this.vehicleAssetsIcon,
    required this.vehicleNumber,
    required this.vehicleColor,
    required this.vehicleModel,
    required this.vehicleBrand,
    required this.rating,
    required this.location,
  });
}
