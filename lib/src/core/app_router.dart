import 'package:go_router/go_router.dart';
import 'package:portfolio/src/views/pages/home_page.dart';

enum AppRoutes {
  home('/');

  final String path;
  const AppRoutes(this.path);
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home.path,
  routes: [
    GoRoute(
      path: AppRoutes.home.path,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
