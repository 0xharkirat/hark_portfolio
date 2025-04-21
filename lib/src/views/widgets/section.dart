import 'dart:developer';

import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({
    super.key,
    this.backgroundColor,
    required this.children,
    this.maxContentWidth = 660.0,
    this.outerPadding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
  });

  final Color? backgroundColor;
  final List<Widget> children;
  final double maxContentWidth;
  final EdgeInsets outerPadding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final windowWidth = constraints.maxWidth.toDouble(); // ✅ fix here

        final computedInnerPadding =
            (((windowWidth - maxContentWidth - outerPadding.horizontal) / 2)
                .clamp(0.0, double.infinity));

        log('Window Width: $windowWidth');
        log('Computed Inner Padding: $computedInnerPadding');

        return Container(
          color: backgroundColor,
          width: double.infinity,
          padding: outerPadding,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: computedInnerPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        );
      },
    );
  }
}
