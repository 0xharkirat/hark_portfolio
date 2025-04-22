import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/src/controllers/theme_mode_controller.dart';
import 'package:portfolio/src/core/app_router.dart';
import 'package:portfolio/src/utils/constants.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:portfolio/src/utils/url_strategy.dart'; // ✅ impo

void main() {
  setUrlStrategy();
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
        colorScheme: ShadNeutralColorScheme.dark(
          background: DarkThemeColors.gray100.color,
          primary: DarkThemeColors.gray1200.color,
          secondary: DarkThemeColors.gray1100.color,
          border: DarkThemeColors.gray400.color,
          card: DarkThemeColors.gray200.color,
        ),
        brightness: Brightness.dark,
        textTheme: ShadTextTheme.fromGoogleFont(fonts),
      ),
      theme: ShadThemeData(
        colorScheme: ShadNeutralColorScheme.light(
          background: LightThemeColors.gray100.color,
          primary: LightThemeColors.gray1200.color,
          secondary: LightThemeColors.gray1100.color,
          border: LightThemeColors.gray400.color,
          card: LightThemeColors.gray200.color,
        ),
        brightness: Brightness.light,
        textTheme: ShadTextTheme.fromGoogleFont(fonts),
      ),
    );
  }
}
