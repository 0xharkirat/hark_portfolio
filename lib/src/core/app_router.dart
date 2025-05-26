import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/src/views/pages/error_page.dart';
import 'package:portfolio/src/views/pages/home_page.dart';
import 'package:portfolio/src/views/pages/labs/labs_page.dart';
import 'package:portfolio/src/views/pages/labs/sub_labs/base_sub_lab_page.dart';
import 'package:portfolio/src/views/pages/poems/poems_page.dart';
import 'package:portfolio/src/views/pages/poems/sub_poems/base_sub_poem_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum AppRoutes {
  home('/', "Harkirat Singh"),
  labs('/labs', "Harkirat Singh · Labs"),
  error('/error', "Harkirat Singh · Error"),
  subLab('/:subLabId', "Harkirat Singh · Labs"),
  poems('/poems', "Harkirat Singh · Poems"),
  subPoem('/:subPoemId', "Harkirat Singh · Poems");


  final String path;
  final String title;
  const AppRoutes(this.path, this.title);
}

void setPageTitle(String title, BuildContext context) {
  SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(
      label: title,
      primaryColor:
          ShadTheme.of(
            context,
          ).colorScheme.primary.toARGB32(), // This line is required
    ),
  );
}

// create extension

enum PathParams { subLabId, subPoemId }

final goRouter = Provider(
  (ref) => GoRouter(
    initialLocation: AppRoutes.home.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.home.path,
        name: AppRoutes.home.name,
        builder: (context, state) {
          setPageTitle(AppRoutes.home.title, context);

          return const HomePage();
        },
      ),
      GoRoute(
        path: AppRoutes.labs.path,
        name: AppRoutes.labs.name,
        builder: (context, state) {
          setPageTitle(AppRoutes.labs.title, context);

          return const LabsPage();
        },
        routes: [
          GoRoute(
            path: AppRoutes.subLab.path,
            name: AppRoutes.subLab.name,
            builder: (context, state) {
              final subLabId = state.pathParameters[PathParams.subLabId.name]!;
              return BaseSubLabPage(subLabId: subLabId);
            },
          ),
        ],
      ),

      GoRoute(
        path: AppRoutes.error.path,
        name: AppRoutes.error.name,
        builder: (context, state) {
          setPageTitle(AppRoutes.error.title, context);
          return const ErrorPage();
        },
      ),

      GoRoute(
        path: AppRoutes.poems.path,
        name: AppRoutes.poems.name,
        builder: (context, state) {
          setPageTitle(AppRoutes.poems.title, context);
          return const PoemsPage(); // Placeholder for poems page
        },
        routes:[
          GoRoute(
            path: AppRoutes.subPoem.path,
            name: AppRoutes.subPoem.name,
            builder: (context, state) {
              final subPoemId = state.pathParameters[PathParams.subPoemId.name]!;
              return BaseSubPoemPage(subPoemId: subPoemId);
            },
          )
        ]
      )
    ],
    errorBuilder: (context, state) {
      setPageTitle(AppRoutes.error.title, context);
      return const ErrorPage();
    },
  ),
);
