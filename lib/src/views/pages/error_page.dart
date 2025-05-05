import 'package:flutter/material.dart';

import 'package:portfolio/src/views/widgets/common/base_page_scaffold.dart';
import 'package:portfolio/src/views/widgets/common/contact.dart';
import 'package:portfolio/src/views/widgets/common/footer.dart';
import 'package:portfolio/src/views/widgets/common/hero_logo_widget.dart';
import 'package:portfolio/src/views/widgets/common/section.dart';
import 'package:portfolio/src/views/widgets/home/hero_section.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePageScaffold(
      spacing: 0,

      children: <Widget>[
        Section(children: [const HeroLogoWidget()]),

        const HeroSection(
          title: "Page does not exist",
          description:
              "This page does not exist. Please check the URL or go back to the home page.",
          showHeroButton: true,
        ),

        const Contact(),

        const Footer(),
      ],
    );
  }
}
