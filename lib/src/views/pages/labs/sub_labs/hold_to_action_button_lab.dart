import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:portfolio/src/controllers/theme_mode_controller.dart';
import 'package:portfolio/src/models/code.dart';
import 'package:portfolio/src/utils/methods.dart';
import 'package:portfolio/src/views/widgets/common/animated_icon_label_button.dart';
import 'package:portfolio/src/views/widgets/common/heading.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';
import 'package:portfolio/src/views/widgets/common/playground_container.dart';
import 'package:portfolio/src/views/widgets/common/section.dart';
import 'package:portfolio/src/views/widgets/package/hold_to_action_button.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum Tab { main, holdToActionButtonLab }

class HoldToActionButtonLab extends ConsumerStatefulWidget {
  const HoldToActionButtonLab({super.key});

  @override
  ConsumerState<HoldToActionButtonLab> createState() =>
      _HoldToActionButtonLabState();
}

class _HoldToActionButtonLabState extends ConsumerState<HoldToActionButtonLab> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
    return Section(
      outerPadding: const EdgeInsets.only(left: 16, right: 16.0, bottom: 40.0),
      children: [
        const P(
          text:
              "Here, this is a counter increment that triggers when the hold is completed. Any callback function can be passed to the `onHoldComplete` field of the button.",
        ),

        const SizedBox(height: 32),

        // The HoldToActionButton demo
        PlaygroundContainer(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HoldToActionButton(
                  backgroundColor: ShadTheme.of(context).colorScheme.primary,
                  icon: Icon(LucideIcons.plus),
                  text: 'Hold to Increment',
                  textColor: ShadTheme.of(context).colorScheme.background,
                  onHoldComplete: _incrementCounter,
                ),

                const SizedBox(height: 32),

                P(text: 'Counter: $_counter', isSelectable: false),
              ],
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
                          selectedTab == Tab.holdToActionButtonLab
                              ? primary
                              : secondary,
                      padding: EdgeInsets.zero,
                      onPressed:
                          () => _onTabSelected(Tab.holdToActionButtonLab),
                      child: Text('hold_to_action_button.dart'),
                    ),
                    const Spacer(),

                    AnimatedIconLabelButton(
                      height: 24,
                      icon: LucideIcons.copy,
                      label: "Copy",
                      onTap: () {
                        final code =
                            selectedTab == Tab.main
                                ? holdToActionButtonExampleCode
                                : holdToActionButtonCode;
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

              // The code snippet
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 16),
                  child:
                      selectedTab == Tab.holdToActionButtonLab
                          ? SelectableText.rich(
                            themeHighlighter(
                              context,
                              themeMode,
                              holdToActionButtonCode,
                            ),
                          )
                          : SelectableText.rich(
                            themeHighlighter(
                              context,
                              themeMode,
                              holdToActionButtonExampleCode,
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
