import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/core/models/place_details/address_component.dart';
import 'package:uber/core/models/place_details/location.dart';
import 'package:uber/core/utils/api_service.dart';
import 'package:uber/features/home/domain/entities/locationentity.dart';

abstract class HomeRemoteDataSource {
  Future<LocationEntity> getPickUPLocation(LatLng latLng);
  Future<LocationEntity> getDropOffLocation(LatLng latLng);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final _dio = Dio();
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);
  @override
  Future<LocationEntity> getDropOffLocation(LatLng latLng) async {
    final apiKey = dotenv.env['GOOGLE_MAPS_KEY'];
    final result = await _dio.get(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$apiKey',
    );

    return getLocationEntity(result.data['results'][0] as Map<String, dynamic>);
  }

  @override
  Future<LocationEntity> getPickUPLocation(LatLng latLng) async {
    final apiKey = dotenv.env['GOOGLE_MAPS_KEY'];

    final result = await _dio.get(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$apiKey',
    );

    return getLocationEntity(result.data['results'][0] as Map<String, dynamic>);
  }

  LocationEntity getLocationEntity(Map<String, dynamic> data) {
    return LocationEntity(
      addressComponents: (data['address_components'] as List<dynamic>?)!
          .map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
      coordinates: Location.fromJson(data['geometry']['location']),
      name: data['formatted_address'] as String,
    );
  }
}
