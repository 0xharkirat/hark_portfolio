import 'package:flutter/material.dart';
import 'package:portfolio/src/views/widgets/common/base_page_scaffold.dart';
import 'package:portfolio/src/views/widgets/common/contact.dart';
import 'package:portfolio/src/views/widgets/common/footer.dart';
import 'package:portfolio/src/views/widgets/home/contributions_section.dart';
import 'package:portfolio/src/views/widgets/home/projects_section.dart';
import 'package:portfolio/src/views/widgets/home/hero_section.dart';
import 'package:portfolio/src/views/widgets/common/header.dart';
import 'package:portfolio/src/views/widgets/home/youtube_section.dart';
import 'package:portfolio/src/views/widgets/labs/labs_section.dart';
import 'package:portfolio/src/views/widgets/poems/poems_section.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePageScaffold(
      spacing: 0,

      children: <Widget>[
        const Header(),

        

        

        const Contact(),

        SizedBox(height: 48),

        

        const Footer(),
      ],
    );
  }
}
