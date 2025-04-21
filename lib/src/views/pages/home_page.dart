import 'package:flutter/material.dart';
import 'package:portfolio/src/views/widgets/contact.dart';
import 'package:portfolio/src/views/widgets/footer.dart';
import 'package:portfolio/src/views/widgets/home/contributions_section.dart';
import 'package:portfolio/src/views/widgets/home/projects_section.dart';
import 'package:portfolio/src/views/widgets/home/hero_section.dart';
import 'package:portfolio/src/views/widgets/header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Header(),

            const HeroSection(),

            const ProjectsSection(),

            const ContributionsSection(),

            const Contact(),

            const Footer(),
          ],
        ),
      ),
    );
  }
}
