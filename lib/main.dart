import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uber/core/utils/app_router.dart';
import 'package:uber/core/utils/bloc_observer.dart';
import 'package:uber/core/utils/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/features/home/domain/repositories/home_repository.dart';
import 'package:uber/features/home/domain/usecases/confirm_tripe_use_case.dart';
import 'package:uber/features/home/domain/usecases/get_drop_off_location_use_case.dart';
import 'package:uber/features/home/domain/usecases/get_pick_up_location_use_case.dart';
import 'package:uber/features/home/presentation/view_model/cubit/confirm_tripe_cubit.dart';
import 'package:uber/features/home/presentation/view_model/get_location_cubit/get_drop_off_location_cubit.dart';
import 'package:uber/features/home/presentation/view_model/get_location_cubit/get_pick_up_location_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await setup();

  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GetPickUpLocationCubit(
                GetPickUpLocationUseCase(getIt.get<HomeRepository>()),
              ),
            ),
            BlocProvider(
              create: (context) => GetDropOffLocationCubit(
                GetDropOffLocationUseCase(getIt.get<HomeRepository>()),
              ),
            ),
            BlocProvider(
              create: (context) => ConfirmTripeCubit(
                ConfirmTripUseCase(getIt.get<HomeRepository>()),
              ),
            ),
          ],
          child: child!,
        );
      },
    );
  }
}
