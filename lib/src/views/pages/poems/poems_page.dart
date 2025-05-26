import 'package:flutter/material.dart';
import 'package:portfolio/src/views/widgets/common/base_page_scaffold.dart';
import 'package:portfolio/src/views/widgets/common/contact.dart';
import 'package:portfolio/src/views/widgets/common/footer.dart';
import 'package:portfolio/src/views/widgets/common/header.dart';
import 'package:portfolio/src/views/widgets/labs/labs_section.dart';
import 'package:portfolio/src/views/widgets/poems/poems_section.dart';

class PoemsPage extends StatelessWidget {
  const PoemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePageScaffold(
      children: [
        const Header(),
        PoemsSection(animate: false),

        const Contact(),
        const Footer(),
      ],
    );
  }
}
