import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  // convert kebab-case to PascalCase
  String kebabToPascalCase() {
    return split('-').map((word) => word.capitalize()).join();
  }
}

extension AnimateWithDelay on Widget {
  Widget withStagger(int index) {
    final delay = Duration(milliseconds: 800 * index);
    const totalCycle = Duration(milliseconds: 6000);

    return animate(
          onPlay: (controller) async {
            final start = DateTime.now();

            while (true) {
              final now = DateTime.now();
              final elapsed = now.difference(start);
              final offset = elapsed.inMilliseconds % totalCycle.inMilliseconds;

              // Wait until this widget’s turn in the cycle
              if (offset < delay.inMilliseconds) {
                await Future.delayed(delay - Duration(milliseconds: offset));
              } else {
                await Future.delayed(
                  totalCycle - Duration(milliseconds: offset) + delay,
                );
              }

              await controller.forward(from: 0);
            }
          },
        )
        .shake(
          delay: Duration.zero,
          duration: 1800.ms,
          hz: 4,
          curve: Curves.easeInOutCubic,
        )
        .scaleXY(
          end: 1.5,
          duration: 600.ms,
          delay: 400.ms,
          curve: Curves.easeOut,
        )
        .then(delay: 600.ms)
        .scaleXY(end: 1 / 1.5, duration: 600.ms);
  }
}
