import 'package:uber/constants.dart';

class ChooseTripTypeEntity {
  final String id;
  final VehicleType name;
  final String description;
  final double price;
  final String assetsIcon;
  final int numOfPerson;
  final int durationInM;

  ChooseTripTypeEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.assetsIcon,
    required this.numOfPerson,
    required this.durationInM,
  });
}
