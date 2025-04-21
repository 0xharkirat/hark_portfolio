import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

const fonts = GoogleFonts.inter;

const kHeadingColor = Color(0xFFeeeeec);

const kPColor = Color(0xFFB5B3AD);

enum DarkThemeColors {
  gray100(Color(0xFF111110)),
  gray200(Color(0xFF191918)),
  gray300(Color(0xFF222221)),
  gray400(Color(0xFF2A2A28)),
  gray500(Color(0xFF31312E)),
  gray600(Color(0xFF3B3A37)),
  gray700(Color(0xFF494844)),
  gray800(Color(0xFF62605B)),
  gray900(Color(0xFF6F6D66)),
  gray1000(Color(0xFF7C7B74)),
  gray1100(Color(0xFFB5B3AD)),
  gray1200(Color(0xFFEEEEEC)),
  grayAlpha100(Color(0x00000000)),
  grayAlpha200(Color(0x09FFFFFF)),
  grayAlpha300(Color(0x12FFFFFF)),
  grayAlpha400(Color(0x1BFFFFFF)),
  grayAlpha500(Color(0x22FFFFFF)),
  grayAlpha600(Color(0x2CFFFFFF)),
  grayAlpha700(Color(0x3BFFFFFF)),
  grayAlpha800(Color(0x55FFFFFF)),
  grayAlpha900(Color(0x64FFFFFF)),
  grayAlpha1000(Color(0x72FFFFFF)),
  grayAlpha1100(Color(0xAFFFFFFF)),
  grayAlpha1200(Color(0xEDFFFFFF));

  final Color color;
  const DarkThemeColors(this.color);
}

enum LightThemeColors {
  gray100(Color(0xFFFDFDFC)),
  gray200(Color(0xFFF9F9F8)),
  gray300(Color(0xFFF1F0EF)),
  gray400(Color(0xFFE9E9E7)),
  gray500(Color(0xFFE2E1DE)),
  gray600(Color(0xFFDAD9D6)),
  gray700(Color(0xFFCFCFCA)),
  gray800(Color(0xFFBCBBB5)),
  gray900(Color(0xFF8D8D86)),
  gray1000(Color(0xFF82827C)),
  gray1100(Color(0xFF63635E)),
  gray1200(Color(0xFF21201C)),
  grayAlpha100(Color(0x03000000)),
  grayAlpha200(Color(0x06000000)),
  grayAlpha300(Color(0x0F000000)),
  grayAlpha400(Color(0x17000000)),
  grayAlpha500(Color(0x1F000000)),
  grayAlpha600(Color(0x26000000)),
  grayAlpha700(Color(0x31000000)),
  grayAlpha800(Color(0x44000000)),
  grayAlpha900(Color(0x72000000)),
  grayAlpha1000(Color(0x7C000000)),
  grayAlpha1100(Color(0x9B000000)),
  grayAlpha1200(Color(0xDF000000));

  final Color color;
  const LightThemeColors(this.color);
}
