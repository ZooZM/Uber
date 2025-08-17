import 'package:go_router/go_router.dart';
import 'package:uber/auth/presentation/view/sign_in_view.dart';
import 'package:uber/features/driver/home/presentation/view/driver_homepage.dart';
import 'package:uber/features/user/home/presentation/view/homepage.dart';

abstract class AppRouter {
  static const String kUserHomeBody = '/UserHomeBody';
  static const String kDriverHomeBody = '/DriverHomeBody';
  static const String kSignIn = '/';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kSignIn,
        builder: (context, state) {
          return const SignInScreen();
        },
      ),
      GoRoute(
        path: kUserHomeBody,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: kDriverHomeBody,
        builder: (context, state) {
          return const DriverHomepage();
        },
      ),
    ],
  );
}
