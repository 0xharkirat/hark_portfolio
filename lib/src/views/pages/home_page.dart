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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePageScaffold(
      spacing: 0,

      children: <Widget>[
        const Header(),

        const HeroSection(
          title: "Who",
          description:
              "I build solutions that are simple, helpful — and sometimes just to show off (but not really). I fail fast, build more, and keep learning better technologies. Building from the land of kangaroos.",
        ),

        const Contact(),

        SizedBox(height: 48),

        const LabsSection(
          animate: true,
        ),

        const ProjectsSection(),

        const ContributionsSection(),

        const YoutubeSection(),

        const SizedBox(height: 48),

        const Footer(),
      ],
    );
  }
}
