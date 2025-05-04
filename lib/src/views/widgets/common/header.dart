import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/src/controllers/theme_mode_controller.dart';
import 'package:portfolio/src/core/app_router.dart';
import 'package:portfolio/src/utils/string_extension.dart';
import 'package:portfolio/src/views/widgets/common/animated_icon_label_button.dart';
import 'package:portfolio/src/views/widgets/common/heading.dart';
import 'package:portfolio/src/views/widgets/common/hero_logo_widget.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';
import 'package:portfolio/src/views/widgets/common/section.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Header extends ConsumerWidget {
  const Header({super.key, this.showThemeButton = true});
  final bool showThemeButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeMode = ref.watch(themeModeProvider);
    final isLabs =
        GoRouter.of(context).state.matchedLocation == AppRoutes.labs.path;

    return Section(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          // mainAxisSize: MainAxisSize.min,
          children: [
            // Left: Name and subtitle
            HeroLogoWidget(),

            // SizedBox(
            //   width: 60,
            //   child: Center(
            //     child: AnimatedIconLabelButton(
            //       icon: LucideIcons.blocks,
            //       label: "Labs",
            //       onTap: () => context.goNamed(AppRoutes.labs.name),
            //       iconColor: ShadTheme.of(context).colorScheme.secondary,
            //       textStyle: ShadTheme.of(context).textTheme.p.copyWith(
            //         color: ShadTheme.of(context).colorScheme.secondary,
            //       ),
            //       direction: AxisDirection.right,
            //       isExapandedFirst: isLabs,

            //       spacing: 4.0,
            //     ),
            //   ),
            // ),

            showThemeButton?
            Container(
              padding: const EdgeInsets.only(right: 8),
              width: 124,
              child: Center(
                child: AnimatedIconLabelButton(
                  icon: appThemeMode.icon,
                  label: appThemeMode.name.capitalize(),
                  onTap:
                      () => ref.read(themeModeProvider.notifier).toggleTheme(),
                  iconColor: ShadTheme.of(context).colorScheme.secondary,
                  textStyle: ShadTheme.of(context).textTheme.p.copyWith(
                    color: ShadTheme.of(context).colorScheme.secondary,
                  ),
                  direction: AxisDirection.right,

                  spacing: 4.0,
                ),
              ),
            ): SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
