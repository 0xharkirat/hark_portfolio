import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/src/controllers/theme_mode_controller.dart';
import 'package:portfolio/src/core/app_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeMode = ref.watch(themeModeProvider);
    return ShadApp.router(
      routerConfig: appRouter,
      title: 'Harkirat Singh',
      themeMode: appThemeMode.themeMode,
      darkTheme: ShadThemeData(
        colorScheme: ShadStoneColorScheme.dark(),
        brightness: Brightness.dark,
      ),
      theme: ShadThemeData(
        colorScheme: ShadStoneColorScheme.light(),
        brightness: Brightness.light,
      ),
    );
  }
}
