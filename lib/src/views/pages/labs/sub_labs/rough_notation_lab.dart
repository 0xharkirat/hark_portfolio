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
import 'package:portfolio/src/views/widgets/labs/embed.dart';
import 'package:portfolio/src/views/widgets/package/hold_to_action_button.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class RoughNotationLab extends ConsumerStatefulWidget {
  const RoughNotationLab({super.key});

  @override
  ConsumerState<RoughNotationLab> createState() => _RoughNotationLabState();
}

class _RoughNotationLabState extends ConsumerState<RoughNotationLab> {
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
              "In this lab, we will explore the [Rough Notation package](https://roughnotation.0xharkirat.com). This package allows you to create animated, hand-drawn-style annotations on widgets. Based on [Rough Notation JS](https://roughnotation.com/).",
        ),

        const SizedBox(height: 16),

        const Heading(
          text: "Full Website",
         
        ),

        const P(
          text:
              "Here, you can see the full website of the Rough Notation package. You can also check out the [roughnotation.0xharkirat.com](https://roughnotation.0xharkirat.com) website.",
        ),

        const SizedBox(height: 16),

        PlaygroundContainer(
          height: 600,
          padding: const EdgeInsets.all(0),
          child: WebEmbed(url: 'https://roughnotation-flutter.web.app', height: 600)),
      ],
    );
  }
}
