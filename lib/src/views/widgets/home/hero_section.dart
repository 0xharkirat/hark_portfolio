import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/src/core/app_router.dart';
import 'package:portfolio/src/views/widgets/common/heading.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';
import 'package:portfolio/src/views/widgets/common/section.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.title,
    required this.description,
    this.outerPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 40.0,
    ),
    this.showHeroButton = false,
  });
  final String title;
  final String description;
  final EdgeInsets outerPadding;
  final bool showHeroButton;

  @override
  Widget build(BuildContext context) {
    return Section(
      outerPadding: outerPadding,
      children: [
        Heading(text: title),
        const SizedBox(height: 20),
        P(text: description),
        const SizedBox(height: 16),
        showHeroButton
            ? Transform.translate(
              offset: const Offset(-4, 0),
              child: ShadButton(
                leading: Icon(LucideIcons.house),
                onPressed: () {
                  context.goNamed(AppRoutes.home.name);
                },

                size: ShadButtonSize.sm,
                child: const Text('Go to Home'),
              ),
            )
            : const SizedBox.shrink(),
      ],
    );
  }
}
