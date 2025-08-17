import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  //http://10.0.2.2
  //http://192.168.1.5  //mobile device
  // https://ta7t-bety-anb3dfg0e2dra6hp.germanywestcentral-01.azurewebsites.net/api/v1/
  final String _baseUrl = dotenv.env['API_BASE_URL']!;
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({
    required String endPoint,
    String? token,
    Map<String, dynamic>? data,
  }) async {
    var response = await _dio.get(
      data: data,
      '$_baseUrl$endPoint',
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: data,
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    var response = await _dio.put(
      '$_baseUrl$endPoint',
      data: data ?? {},
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    String? token,
  }) async {
    var response = await _dio.delete(
      '$_baseUrl$endPoint',
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> patch({
    required String endPoint,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    var response = await _dio.patch(
      '$_baseUrl$endPoint',
      data: data ?? {},
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> uploadFile({
    required String endPoint,
    required FormData data,
    String? token,
  }) async {
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: data,
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    return response.data;
  }
}
