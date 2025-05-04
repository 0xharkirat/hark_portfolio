import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Heading extends StatelessWidget {
  const Heading({
    super.key,
    required this.text,
    this.isSelectable = true,
    this.textStyle,
  });

  final String text;
  final bool isSelectable;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final style =
        textStyle ??
        ShadTheme.of(context).textTheme.p.copyWith(
          fontSize: 16,
          color: ShadTheme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w500,
        );

    return isSelectable
        ? SelectableText(text, style: style)
        : Text(text, style: style);
  }
}
