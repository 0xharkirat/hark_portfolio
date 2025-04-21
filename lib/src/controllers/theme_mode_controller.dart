import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum AppThemeMode {
  system(ThemeMode.system, LucideIcons.laptop),
  light(ThemeMode.light, LucideIcons.sun),
  dark(ThemeMode.dark, LucideIcons.moon);

  final ThemeMode themeMode;
  final IconData icon;
  const AppThemeMode(this.themeMode, this.icon);
}

class ThemeModeController extends Notifier<AppThemeMode> {
  @override
  AppThemeMode build() {
    return AppThemeMode.system;
  }

  void toggleTheme() {
    final currentIndex = AppThemeMode.values.indexOf(state);
    final nextIndex = (currentIndex + 1) % AppThemeMode.values.length;
    state = AppThemeMode.values[nextIndex];
  }
}

final themeModeProvider = NotifierProvider<ThemeModeController, AppThemeMode>(
  ThemeModeController.new,
);


