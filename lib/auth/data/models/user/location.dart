import 'point.dart';

class Location {
  final Point coordinates;
  final String address;
  final bool isFavorite;
  final String id;

  Location({
    required this.coordinates,
    required this.address,
    required this.isFavorite,
    required this.id,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    coordinates: Point.fromJson(json['coordinates'] as Map<String, dynamic>),
    address: json['address'] as String,
    isFavorite: json['isFavorite'] as bool,
    id: json['_id'] as String,
  );

  Map<String, dynamic> toJson() => {
    'coordinates': coordinates.toJson(),
    'address': address,
    'isFavorite': isFavorite,
    '_id': id,
  };
}
