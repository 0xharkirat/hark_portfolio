import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PlaygroundContainer extends StatelessWidget {
  const PlaygroundContainer({
    super.key,
    this.child,
    this.height = 300,
    this.padding = const EdgeInsets.all(16),
  });

  final double height;
  final Widget? child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: ShadTheme.of(context).colorScheme.popover,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ShadTheme.of(context).colorScheme.border,
          width: 2,
        ),
      ),

      child: child,
    );
  }
}
