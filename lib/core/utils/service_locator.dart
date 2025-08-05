import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:uber/core/utils/api_service.dart';
import 'package:uber/features/home/data/datasources/home_remote_data_source.dart';
import 'package:uber/features/home/data/repositories/home_repo_impl.dart';
import 'package:uber/features/home/domain/repositories/home_repository.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<HomeRepository>(
    HomeRepoImpl(HomeRemoteDataSourceImpl(getIt.get<ApiService>())),
  );
}
