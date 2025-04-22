import 'package:flutter/material.dart';
import 'package:portfolio/src/utils/methods.dart';
import 'package:portfolio/src/views/widgets/common/heading.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';
import 'package:portfolio/src/views/widgets/common/section.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:textf/textf.dart';


class Footer extends StatelessWidget {
  const Footer({super.key});


  

  @override
  Widget build(BuildContext context) {
    final color = ShadTheme.of(context).colorScheme.secondary;
    final style = ShadTheme.of(
      context,
    ).textTheme.p.copyWith(fontSize: 16, color: color);
    return Section(
      children: [
        Heading(text: "Socials & More"),
        const SizedBox(height: 20),
        TextfOptions(
          onUrlTap: (url, displayText) => linkOpen(url),
          urlHoverStyle: style.copyWith(
            decoration: TextDecoration.underline,
            decorationColor: color,
         
          ),
          urlStyle: style.copyWith(
            decoration: TextDecoration.underline,
            decorationColor: color,
           
          ),
          child: Textf(
            "I share my work on [Twitter/X](https://x.com/intent/follow?screen_name=0xharkirat) and code on [GitHub](https://github.com/0xharkirat).",
            style: style
          ),
        ),
        const SizedBox(height: 20),
        P(text: "I acknowledge and deeply appreciate the original design, creativity, and overall inspiration behind this site — all credited to Emil Kowalski. This version is a Flutter-based reimagination of his beautifully crafted portfolio, built for learning, admiration, and open source love.")
      ],
    );
  }
}
