import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uber/core/utils/location_service.dart';

class SocketService {
  IO.Socket? _socket;
  Timer? _locationTimer;
  void connect() {
    final String baseUrl = dotenv.env['API_BASE_URL']!;
    _socket = IO.io(
      baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    _socket!.connect();
    _socket!.onConnect((_) {
      print("✅ Connected with id: ${_socket!.id}");
    });
  }

  void registerDriver(String userId, List<double> coords, String vehicleType) {
    _socket?.emit('register', {
      'userId': userId,
      'role': 'driver',
      'coords': coords,
    });
  }

  void onRegisterSuccess(Function(dynamic data) callback) {
    _socket?.on('register:success', callback);
  }

  void goOnline(
    String userId,
    double latitude,
    double longitude,
    String vehicleType,
  ) {
    _socket?.emit('captain_online', {
      'userId': userId,
      'location': {
        'type': 'Point',
        'coordinates': [longitude, latitude],
      },
      'vehicleType': vehicleType,
    });
    startLocationUpdates(userId);
  }

  void startLocationUpdates(String userId) {
    _locationTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      try {
        LocationService locationService = LocationService();
        LocationData position = await locationService.getLocation();

        locationUpdate(userId, [
          position.latitude!,
          position.longitude!,
        ], position.heading!);
      } catch (e) {
        print("❌ Error getting location: $e");
      }
    });
  }

  void stopLocationUpdates() {
    _locationTimer?.cancel();
    _locationTimer = null;
  }

  void locationUpdate(String userId, List<double> coord, double heading) {
    _socket?.emit('location_update', {
      'userId': userId,
      'location': {
        'type': 'Point',
        'coordinates': [coord[1], coord[0]],
      },
      'heading': heading,
    });
  }

  void goOffline(String userId) {
    _socket?.emit('captain_offline', {'userId': userId});
    stopLocationUpdates();
  }

  void disconnect() {
    _socket?.disconnect();
  }
}
