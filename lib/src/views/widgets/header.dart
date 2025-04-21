import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/src/controllers/theme_mode_controller.dart';
import 'package:portfolio/src/core/app_router.dart';
import 'package:portfolio/src/utils/string_extension.dart';
import 'package:portfolio/src/views/widgets/heading.dart';
import 'package:portfolio/src/views/widgets/p.dart';
import 'package:portfolio/src/views/widgets/section.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Header extends ConsumerWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeMode = ref.watch(themeModeProvider);

    return Section(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Left: Name and subtitle
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              hoverColor: Colors.transparent,

              onTap: () {
                context.goNamed(AppRoutes.home.name);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Heading(text: 'Harkirat Singh', isSelectable: false),

                  P(text: 'Software Artisan', isSelectable: false),
                ],
              ),
            ),
            const Spacer(),

            InkWell(
              onTap: () {
                ref.read(themeModeProvider.notifier).toggleTheme();
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              hoverColor: Colors.transparent,

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    appThemeMode.icon,
                    color: ShadTheme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    appThemeMode.name.capitalize(),
                    style: ShadTheme.of(context).textTheme.p.copyWith(
                      color: ShadTheme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
