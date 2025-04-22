import 'package:go_router/go_router.dart';
import 'package:portfolio/src/views/pages/home_page.dart';
import 'package:portfolio/src/views/pages/labs/labs_page.dart';
import 'package:portfolio/src/views/pages/labs/sub_labs/sub_lab_page.dart';

enum AppRoutes {
  home('/'),
  labs('/labs'),
  subLab('/:subLabId');

  final String path;
  const AppRoutes(this.path);
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home.path,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.home.path,
      name: AppRoutes.home.name,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.labs.path,
      name: AppRoutes.labs.name,
      builder: (context, state) => const LabsPage(),
      routes: [
        GoRoute(
          path: AppRoutes.subLab.path,
          name: AppRoutes.subLab.name,
          builder: (context, state) {
            final subLabId = state.pathParameters['subLabId']!;
            return SubLabPage(subLabId: subLabId);
          },
        ),
      ],
    ),
  ],
);
