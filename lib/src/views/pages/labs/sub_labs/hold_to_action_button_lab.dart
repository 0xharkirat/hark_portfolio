import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';
import 'package:portfolio/src/views/widgets/common/section.dart';
import 'package:portfolio/src/views/widgets/package/hold_to_action_button.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HoldToActionButtonLab extends StatefulWidget {
  const HoldToActionButtonLab({super.key});

  @override
  State<HoldToActionButtonLab> createState() => _HoldToActionButtonLabState();
}

class _HoldToActionButtonLabState extends State<HoldToActionButtonLab> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Section(
        outerPadding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const P(text: "I am implementing a counter increment that triggers when the hold is completed. Any callback function can be passed to the `onHoldComplete` field of the button.", fontWeight: FontWeight.bold),

      
      
          const SizedBox(height: 32),
      
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: ShadTheme.of(context).colorScheme.popover,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: ShadTheme.of(context).colorScheme.border,
                width: 2,
              ),
            ),
      
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HoldToActionButton(
                    icon: Icon(LucideIcons.plus),
                    text: 'Hold to Increment',
                    onHoldComplete: _incrementCounter,
                  ),
      
                  const SizedBox(height: 32),
      
                  P(text: 'Counter: $_counter', isSelectable: false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
