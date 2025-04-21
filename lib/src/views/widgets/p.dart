import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class P extends StatelessWidget {
  const P({super.key, required this.text, this.isSelectable = true});
  final String text;
  final bool isSelectable;

  @override
  Widget build(BuildContext context) {
    final style = ShadTheme.of(
      context,
    ).textTheme.p.copyWith(fontSize: 16, color: ShadTheme.of(context).colorScheme.secondary);

    return isSelectable
        ? SelectableText(text, style: style)
        : Text(text, style: style);
  }
}
