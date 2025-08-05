import 'package:uber/constants.dart';
import 'package:uber/features/home/domain/entities/tripe_entity.dart';

class ChooseTripTypeEntity {
  final String id;
  final VehicleType name;
  final String description;
  final double price;
  final String assetsIcon;
  final int numOfPerson;
  final int durationInM;
  final TripeModel tripEntity;

  ChooseTripTypeEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.assetsIcon,
    required this.numOfPerson,
    required this.durationInM,
    required this.tripEntity,
  });
}
