import 'package:flutter/material.dart';
import 'package:portfolio/src/utils/constants.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        
        SelectableText(
          'Who',
          style: ShadTheme.of(context).textTheme.p.copyWith(
           
            fontSize: 16,
            color: DarkThemeColors.gray1200.color,
          ),
        ),
        const SizedBox(height: 20),
        SelectableText(
          "I build solutions that are simple, helpful — and sometimes just to show off (but not really).\nI fail fast, build more, and keep learning better technologies.\nBuilding from the land of kangaroos.",
          style: ShadTheme.of(context).textTheme.p.copyWith(
            fontSize: 16,
            color: DarkThemeColors.gray1100.color,
          ),
        ),
      ],
    );
  }
}
