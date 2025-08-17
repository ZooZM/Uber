import 'package:uber/core/models/place_details/place_details.dart';

class TripeModel {
  final String uId;
  final String tripId;
  final String cId;
  final PlaceDetails pickupLocation;
  final PlaceDetails dropoffLocation;
  final String vehicleType;

  TripeModel(
    this.uId,
    this.tripId,
    this.cId,
    this.vehicleType, {
    required this.pickupLocation,
    required this.dropoffLocation,
  });
}
