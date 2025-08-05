import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uber/core/models/place_details/place_details.dart';

class PlacesService {
  final String url = 'https://maps.googleapis.com/maps/api/place';
  final String apiKey = 'AIzaSyBKxRrZ4PuAC8fvWcI81iEnvakt3by3HA0';

  Future<PlaceDetails> getPlaceDetailsByLatLng({
    required double latitude,
    required double longitude,
  }) async {
    final response = await http.get(
      Uri.parse('$url/details/json?latlng=$latitude,$longitude&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['result'];
      return PlaceDetails.fromJson(jsonData);
    } else {
      throw Exception("Failed to fetch place details");
    }
  }
}
