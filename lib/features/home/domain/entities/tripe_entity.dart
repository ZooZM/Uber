import 'package:uber/features/home/domain/entities/locationentity.dart';

class TripeModel {
  final LocationEntity pickupLocation;
  final LocationEntity dropoffLocation;
  final num distance;
  TripeModel({
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.distance,
  });
}
