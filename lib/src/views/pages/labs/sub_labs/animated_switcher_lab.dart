import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/src/controllers/theme_mode_controller.dart';
import 'package:portfolio/src/utils/string_extension.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';
import 'package:portfolio/src/views/widgets/common/playground_container.dart';
import 'package:portfolio/src/views/widgets/common/section.dart';
import 'package:portfolio/src/views/widgets/package/animated_switcher_toggle_button.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AnimatedSwitcherLab extends ConsumerWidget {
  const AnimatedSwitcherLab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    

    final currentMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);

    final states =
        AppThemeMode.values.map((mode) {
          return ToggleState(
            label: mode.name.capitalize(),
            icon: mode.icon,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          );
        }).toList();

    final currentIndex = AppThemeMode.values.indexOf(currentMode);

    return Section(
      outerPadding: const EdgeInsets.only(left: 16, right: 16.0, bottom: 40.0),
      children: [
        const P(
          text:
              "In this lab, I will showcase Flutter version of the button originally tweeted by [Jakub Krehel](https://x.com/jakubkrehel/status/1911816000107901308). I have extended the capabilities to include mulitple states - min 2.",
        ),
        const SizedBox(height: 32),
        PlaygroundContainer(
          child: Center(
            child: AnimatedSwitcherToggleButton(
              trailing: Text("mode"),
              states: states,
              initialIndex: currentIndex,
              changeIndexTo: currentIndex,
              onChanged: (index) {
                themeNotifier.toggleTheme();
              },
            ),
          ),
        ),
      ],
    );
  }
}
