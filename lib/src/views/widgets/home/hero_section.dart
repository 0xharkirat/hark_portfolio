import 'package:flutter/material.dart';
import 'package:portfolio/src/views/widgets/heading.dart';
import 'package:portfolio/src/views/widgets/p.dart';
import 'package:portfolio/src/views/widgets/section.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      children: [
        Heading(text: "Who"),
        const SizedBox(height: 20),
        P(
          text:
              "I build solutions that are simple, helpful — and sometimes just to show off (but not really).\nI fail fast, build more, and keep learning better technologies.\nBuilding from the land of kangaroos.",
        ),
      ],
    );
  }
}
