class Point {
  final String type;
  final List<double> coordinates;

  Point({
    required this.type,
    required this.coordinates,
  });

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        type: json['type'] as String,
        coordinates: (json['coordinates'] as List<dynamic>)
            .map((e) => e as double)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
      };
}
