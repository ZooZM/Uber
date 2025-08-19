import 'package:uber/core/utils/api_service.dart';

abstract class DriverHomeRemoteDataSource {
  Future<void> goOnline({required String userId, required List<double> coord});
  Future<void> goOffline(String userId);
}

class DriverHomeRemoteDataSourceImpl implements DriverHomeRemoteDataSource {
  final ApiService apiService;

  DriverHomeRemoteDataSourceImpl(this.apiService);

  @override
  Future<void> goOffline(String userId) async {
    // TODO: implement goOffline
    throw UnimplementedError();
  }

  @override
  Future<void> goOnline({required String userId, required List<double> coord}) {
    // TODO: implement goOnline
    throw UnimplementedError();
  }
}
