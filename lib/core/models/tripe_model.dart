import 'package:uber/core/models/place_details/place_details.dart';

class TripeModel {
  final String uId;
  final String tripTypeId;
  final String cId;
  final PlaceDetails pickupLocation;
  final PlaceDetails dropoffLocation;

  TripeModel(
    this.uId,
    this.tripTypeId,
    this.cId, {
    required this.pickupLocation,
    required this.dropoffLocation,
  });
}
