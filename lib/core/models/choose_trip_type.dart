class ChooseTripType {
	double? distance;
	double? duration;
	double? car;
	double? scoter;

	ChooseTripType({this.distance, this.duration, this.car, this.scoter});

	factory ChooseTripType.fromJson(Map<String, dynamic> json) {
		return ChooseTripType(
			distance: (json['distance'] as num?)?.toDouble(),
			duration: (json['duration'] as num?)?.toDouble(),
			car: (json['car'] as num?)?.toDouble(),
			scoter: (json['scoter'] as num?)?.toDouble(),
		);
	}



	Map<String, dynamic> toJson() => {
				'distance': distance,
				'duration': duration,
				'car': car,
				'scoter': scoter,
			};
}
