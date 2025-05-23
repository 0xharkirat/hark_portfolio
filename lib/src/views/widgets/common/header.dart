import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/src/controllers/theme_mode_controller.dart';
import 'package:portfolio/src/core/app_router.dart';
import 'package:portfolio/src/utils/string_extension.dart';
import 'package:portfolio/src/views/widgets/common/animated_icon_label_button.dart';
import 'package:portfolio/src/views/widgets/common/hero_logo_widget.dart';

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
            // MouseRegion(
            //   cursor: SystemMouseCursors.click,
            //   child: GestureDetector(
            //     onTap: () => ref.read(themeModeProvider.notifier).toggleTheme(),
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Icon(
            //           appThemeMode.icon,
            //           color: ShadTheme.of(context).colorScheme.secondary,
            //         ),
            //         const SizedBox(width: 4),
            //         Text(
            //           appThemeMode.name.capitalize(),
            //           style: ShadTheme.of(context).textTheme.p.copyWith(
            //             color: ShadTheme.of(context).colorScheme.secondary,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            ThemeToggleButton(),

            // showThemeButton
            //     ? Container(
            //       padding: const EdgeInsets.only(right: 8),
            //       width: 124,
            //       child: Center(
            //         child: AnimatedIconLabelButton(
            //           icon: appThemeMode.icon,
            //           label: appThemeMode.name.capitalize(),
            //           onTap:
            //               () =>
            //                   ref
            //                       .read(themeModeProvider.notifier)
            //                       .toggleTheme(),
            //           iconColor: ShadTheme.of(context).colorScheme.secondary,
            //           textStyle: ShadTheme.of(context).textTheme.p.copyWith(
            //             color: ShadTheme.of(context).colorScheme.secondary,
            //           ),
            //           direction: AxisDirection.right,

            //           spacing: 4.0,
            //         ),
            //       ),
            //     )
            //     : SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);
    final color = ShadTheme.of(context).colorScheme.secondary;

    return SizedBox(
      width: 124,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => themeNotifier.toggleTheme(),

          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeInOutCubic,
            switchOutCurve: Curves.easeInOutCubic,
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Row(
              key: ValueKey(appThemeMode.name), // Important for switching
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(appThemeMode.icon, color: color),
                const SizedBox(width: 4),
                Text(
                  appThemeMode.name.capitalize(),
                  style: ShadTheme.of(context).textTheme.p.copyWith(color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
