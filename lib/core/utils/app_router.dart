import 'package:go_router/go_router.dart';
import 'package:uber/features/home/presentation/view/homepage.dart';

abstract class AppRouter {
  static const String kHomeBody = '/';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kHomeBody,
        builder: (context, state) {
          return const HomePage();
        },
      ),
    ],
  );
}
