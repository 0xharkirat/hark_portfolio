import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/src/controllers/theme_mode_controller.dart';
import 'package:portfolio/src/utils/constants.dart';
import 'package:portfolio/src/utils/string_extension.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TopBar extends ConsumerWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeMode = ref.watch(themeModeProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Left: Name and subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Harkirat Singh',
                style: ShadTheme.of(context).textTheme.p.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: DarkThemeColors.gray1200.color,
                ),
              ),

              Text(
                'Software Artisan',
                style: ShadTheme.of(
                  context,
                ).textTheme.p.copyWith(fontSize: 16, color: DarkThemeColors.gray1100.color),
              ),
            ],
          ),
        ),

        // InkWell(
        //   onTap: () {
        //     ref.read(themeModeProvider.notifier).toggleTheme();
        //   },
        //   highlightColor: Colors.transparent,
        //   splashColor: Colors.transparent,
        //   splashFactory: NoSplash.splashFactory,
        //   hoverColor: Colors.transparent,

        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Icon(appThemeMode.icon),
        //       const SizedBox(width: 4),
        //       Text(
        //         appThemeMode.name.capitalize(),
        //         style: ShadTheme.of(context).textTheme.p,
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
