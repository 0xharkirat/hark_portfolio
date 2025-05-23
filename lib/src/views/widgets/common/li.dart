import 'package:flutter/material.dart';

import 'package:portfolio/src/views/widgets/common/heading.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LI extends StatelessWidget {
  const LI({super.key, required this.heading, required this.p, this.onTap});
  final Heading heading;
  final P p;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-16, 0),
      child: ListTile(
        mouseCursor: SystemMouseCursors.click,
        selectedColor: Colors.transparent,
        selectedTileColor: Colors.transparent,
        tileColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        minVerticalPadding: 0,
        hoverColor: ShadTheme.of(context).colorScheme.card,
        contentPadding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: heading,
        subtitle: p,
        onTap: onTap ?? () {},
      ),
    );
  }
}
