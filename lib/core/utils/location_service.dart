import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  Future<void> isEnabled() async {
    var locationEnable = await location.serviceEnabled();
    if (!locationEnable) {
      locationEnable = await location.requestService();
    }
    if (!locationEnable) throw LocationEnabledException;
  }

  Future<void> hasPermission() async {
    var locationPermission = await location.hasPermission();
    if (locationPermission == PermissionStatus.deniedForever) {
      throw LocationPremissionException;
    }
    if (locationPermission == PermissionStatus.denied) {
      locationPermission = await location.requestPermission();
      if (locationPermission != PermissionStatus.granted) {
        throw LocationPremissionException;
      }
    }
  }

  void getRealTime(void Function(LocationData)? onData) {
    location.onLocationChanged.listen(onData);
  }

  void setDinstantFilter(double dinstantFilter) {
    location.changeSettings(
      distanceFilter: dinstantFilter,
    );
  }

  Future<LocationData> getLocation() async {
    await isEnabled();
    await hasPermission();
    return await location.getLocation();
  }
}

class LocationEnabledException implements Exception {}

class LocationPremissionException implements Exception {}
