import 'package:flutter/material.dart';
import 'package:portfolio/src/utils/methods.dart';

import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:textf/textf.dart';

class P extends StatelessWidget {
  const P({
    super.key,
    required this.text,
    this.isSelectable = true,
    this.fontWeight = FontWeight.normal,
  });
  final String text;
  final bool isSelectable;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final style = ShadTheme.of(context).textTheme.p.copyWith(
      fontSize: 16,
      color: ShadTheme.of(context).colorScheme.secondary,
      fontWeight: fontWeight,
    );

    final color = ShadTheme.of(context).colorScheme.secondary;
    final primary = ShadTheme.of(context).colorScheme.primary;

    return isSelectable
        ? SelectionArea(
          child: TextfOptions(
            codeStyle: style.copyWith(
              color: primary,

              fontWeight: FontWeight.w500,
            ),
            onUrlTap: (url, displayText) => linkOpen(url),
            urlHoverStyle: style.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: color,
            ),
            urlStyle: style.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: color,
            ),
            child: Textf(text, style: style),
          ),
        )
        : TextfOptions(
          onUrlTap: (url, displayText) => linkOpen(url),
          urlHoverStyle: style.copyWith(
            decoration: TextDecoration.underline,
            decorationColor: color,
          ),
          urlStyle: style.copyWith(
            decoration: TextDecoration.underline,
            decorationColor: color,
          ),
          child: Textf(text, style: style),
        );
  }
}
