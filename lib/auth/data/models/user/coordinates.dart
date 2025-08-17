class Coordinates {
  String? type;
  List<double>? coordinates;

  Coordinates({this.type, this.coordinates});

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        type: json['type'] as String?,
        coordinates: (json['coordinates'] as List<dynamic>?)
            ?.map(
                (e) => (e as num).toDouble()) // Ensures correct type conversion
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
      };
}
