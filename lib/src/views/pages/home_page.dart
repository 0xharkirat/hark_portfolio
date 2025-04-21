import 'package:flutter/material.dart';
import 'package:portfolio/src/views/widgets/base_scaffold.dart';
import 'package:portfolio/src/views/widgets/home/hero_section.dart';
import 'package:portfolio/src/views/widgets/top_bar.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Section(
          children: <Widget>[
            const TopBar(),
            const SizedBox(height: 128),
            const HeroSection(),
          ],
        ),
      ),
    );
  }
}
