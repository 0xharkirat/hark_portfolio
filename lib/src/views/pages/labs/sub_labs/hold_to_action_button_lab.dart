import 'package:flutter/material.dart';
import 'package:portfolio/src/views/widgets/common/animated_icon_label_button.dart';
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
    return Section(
      outerPadding: const EdgeInsets.only(left: 16, right: 16.0, bottom: 40.0),
      children: [
        
        const P(
          text:
              "Here, this a counter increment that triggers when the hold is completed. Any callback function can be passed to the `onHoldComplete` field of the button.",
          fontWeight: FontWeight.bold,
        ),
    
        const SizedBox(height: 32),


        // The HoldToActionButton demo
        Container(
          height: 300,
          padding: const EdgeInsets.all(16),
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
             
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: AnimatedIconLabelButton(
                  icon: LucideIcons.code,
                  label: "See Code",
                  onTap: () {},
                  iconColor: ShadTheme.of(context).colorScheme.primary,
                  textStyle: ShadTheme.of(context).textTheme.p.copyWith(
                    color: ShadTheme.of(context).colorScheme.primary,
                  ),
                 
                ),
                ),
                Spacer(),
                HoldToActionButton(
                  backgroundColor: ShadTheme.of(context).colorScheme.primary,
                  icon: Icon(LucideIcons.plus),
                  text: 'Hold to Increment',
                  onHoldComplete: _incrementCounter,
                ),
    
                const SizedBox(height: 32),
    
                P(text: 'Counter: $_counter', isSelectable: false),
                Spacer()
              ],
            ),
          ),
        ),

        
      ],
    );
  }
}
