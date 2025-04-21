import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

const fonts = GoogleFonts.inter;

enum DarkThemeColors {
  gray100(Color(0xFF111110)),
  gray200(Color(0xFF191918)),
  gray400(Color(0xFF2A2A28)),
  gray800(Color(0xFF62605B)),
  gray1100(Color(0xFFB5B3AD)),
  gray1200(Color(0xFFEEEEEC));

  final Color color;
  const DarkThemeColors(this.color);
}

enum LightThemeColors {
  gray100(Color(0xFFFDFDFC)),
  gray200(Color(0xFFF5F4F4)),
  gray400(Color(0xFFE9E9E7)),
  gray800(Color(0xFFBCBBB5)),
  gray1100(Color(0xFF63635E)),
  gray1200(Color(0xFF21201C));

  final Color color;
  const LightThemeColors(this.color);
}
