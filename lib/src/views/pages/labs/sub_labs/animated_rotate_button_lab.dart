import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/src/controllers/theme_mode_controller.dart';
import 'package:portfolio/src/models/code.dart';
import 'package:portfolio/src/utils/methods.dart';
import 'package:portfolio/src/utils/string_extension.dart';
import 'package:portfolio/src/views/widgets/common/animated_icon_label_button.dart';
import 'package:portfolio/src/views/widgets/common/heading.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';
import 'package:portfolio/src/views/widgets/common/playground_container.dart';
import 'package:portfolio/src/views/widgets/common/section.dart';
import 'package:portfolio/src/views/widgets/package/animated_rotate_button.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum Tab {main, animatedRotateButton}

class AnimatedSwitcherLab extends ConsumerStatefulWidget {
  const AnimatedSwitcherLab({super.key});

  @override
  ConsumerState<AnimatedSwitcherLab> createState() =>
      _AnimatedSwitcherLabState();
}

class _AnimatedSwitcherLabState extends ConsumerState<AnimatedSwitcherLab> {
  Tab selectedTab = Tab.main;

  void _onTabSelected(Tab tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final secondary = ShadTheme.of(context).colorScheme.secondary;
    final primary = ShadTheme.of(context).colorScheme.primary;

    final currentMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);

    final states =
        AppThemeMode.values.map((mode) {
          return RotateState(
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
              "In this lab, I will showcase Flutter version of the button originally tweeted by [Jakub Krehel](https://x.com/jakubkrehel/status/1911816000107901308). I have extended the capabilities to include mulitple states.",
        ),
        const SizedBox(height: 32),
        PlaygroundContainer(
          child: Center(
            child: AnimatedRotateButton(
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

        const SizedBox(height: 32),

        const Heading(text: 'Code Snippet'),

        const SizedBox(height: 16),

        PlaygroundContainer(
          height: 600,
          padding: EdgeInsets.zero,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  // bottom border
                  border: Border(
                    bottom: BorderSide(
                      color: ShadTheme.of(context).colorScheme.border,
                      width: 2,
                    ),
                  ),
                ),

                // Code snippet tabs
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ShadButton.link(
                      hoverForegroundColor: primary,
                      foregroundColor:
                          selectedTab == Tab.main ? primary : secondary,

                      padding: EdgeInsets.zero,
                      onPressed: () => _onTabSelected(Tab.main),
                      child: Text('main.dart'),
                    ),
                    const SizedBox(width: 8),
                    ShadButton.link(
                      hoverForegroundColor: primary,
                      foregroundColor:
                          selectedTab == Tab.animatedRotateButton
                              ? primary
                              : secondary,
                      padding: EdgeInsets.zero,
                      onPressed:
                          () => _onTabSelected(Tab.animatedRotateButton),
                      child: Text('animated_rotate_button.dart'),
                    ),
                    const Spacer(),

                    AnimatedIconLabelButton(
                      height: 24,
                      icon: LucideIcons.copy,
                      label: "Copy",
                      onTap: () {
                        final code =
                            selectedTab == Tab.main
                                ? animatedRotateButtonCode
                                : animatedRotateButtonExampleCode;
                        copyText(code);
                        ShadToaster.of(
                          context,
                        ).show(showToast(title: Heading(text: "Copied")));
                      },
                      iconColor: ShadTheme.of(context).colorScheme.primary,
                      textStyle: TextStyle(
                        color: ShadTheme.of(context).colorScheme.primary,
                      ),
                      direction: AxisDirection.right,

                      spacing: 4.0,
                    ),
                  ],
                ),
              ),

        
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: selectedTab == Tab.animatedRotateButton
                          ? SelectableText.rich(
                            themeHighlighter(
                              context,
                              themeMode,
                              animatedRotateButtonCode,
                            ),
                          )
                          : SelectableText.rich(
                            themeHighlighter(
                              context,
                              themeMode,
                              animatedRotateButtonExampleCode,
                            ),
                          ),
                  ),
                      
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
