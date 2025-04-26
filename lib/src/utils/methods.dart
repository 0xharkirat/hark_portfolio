import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/src/controllers/theme_mode_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> linkOpen(String url) async {
  final Uri url0 = Uri.parse(url);
  if (!await launchUrl(url0)) {
    throw Exception('Could not launch $url0');
  }
}

TextSpan themeHighlighter(
  BuildContext context,
  AppThemeMode appThemeMode,
  String code,
) {
  // Determine if the effective theme is dark
  bool isDarkMode = false;

  if (appThemeMode == AppThemeMode.dark) {
    isDarkMode = true;
  } else if (appThemeMode == AppThemeMode.light) {
    isDarkMode = false;
  } else {
    // AppThemeMode.system
    final brightness = MediaQuery.of(context).platformBrightness;
    isDarkMode = brightness == Brightness.dark;
  }

  return isDarkMode
      ? dartDarkHighlighter.highlight(code)
      : dartLightHighlighter.highlight(code);
}

void copyText(String text) {
  Clipboard.setData(ClipboardData(text: text));
}

ShadToast showToast({
  Duration duration = const Duration(seconds: 5),
  bool showCloseIconOnlyWhenHovered = false,
  ShadPosition shadPosition = const ShadPosition(right: 0, top: 0, bottom: 0),
  Alignment bottomCenter = Alignment.bottomCenter,
  required Widget title,
  Widget? description,
}) {
  return ShadToast(
    duration: duration,
    showCloseIconOnlyWhenHovered: showCloseIconOnlyWhenHovered,
    closeIconPosition: shadPosition,
    alignment: bottomCenter,
    title: title,
    description: description,
  );
}
