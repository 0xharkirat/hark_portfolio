import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode {
  system(ThemeMode.system, LucideIcons.laptop),
  light(ThemeMode.light, LucideIcons.sun),
  dark(ThemeMode.dark, LucideIcons.moon);

  final ThemeMode themeMode;
  final IconData icon;
  const AppThemeMode(this.themeMode, this.icon);
}


class ThemeModeController extends Notifier<AppThemeMode> {
  static const _themeModeKey = 'theme_mode';

  @override
  AppThemeMode build() {
    // Start with a default fallback
    _loadThemeMode(); // Async load (no need to await)
    return AppThemeMode.dark;
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString(_themeModeKey);
    final resolved = AppThemeMode.values.firstWhere(
      (mode) => mode.name == themeModeString,
      orElse: () => AppThemeMode.dark,
    );

    if (resolved != state) {
      state = resolved; // Triggers UI rebuild
    }
  }

  Future<void> toggleTheme() async {
    final currentIndex = AppThemeMode.values.indexOf(state);
    final nextIndex = (currentIndex + 1) % AppThemeMode.values.length;
    final nextMode = AppThemeMode.values[nextIndex];
    state = nextMode;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, nextMode.name);
  }
}

final themeModeProvider =
    NotifierProvider<ThemeModeController, AppThemeMode>(
  ThemeModeController.new,
);


