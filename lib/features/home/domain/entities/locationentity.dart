import 'package:uber/core/models/place_details/address_component.dart';

import '../../../../core/models/place_details/location.dart';

class LocationEntity {
  final String name;
  final List<AddressComponent> addressComponents;
  final Location coordinates;
  LocationEntity({
    required this.name,
    required this.addressComponents,
    required this.coordinates,
  });

  LocationEntity copyWith({required String name}) {
    return LocationEntity(
      name: name,
      addressComponents: addressComponents,
      coordinates: coordinates,
    );
  }
}
