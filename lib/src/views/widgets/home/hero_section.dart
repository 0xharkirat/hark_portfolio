import 'package:flutter/material.dart';
import 'package:portfolio/src/views/widgets/common/heading.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';
import 'package:portfolio/src/views/widgets/common/section.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.title,
    required this.description,
    this.outerPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 40.0),
  });
  final String title;
  final String description;
  final EdgeInsets outerPadding;

  @override
  Widget build(BuildContext context) {
    return Section(
      outerPadding: outerPadding,
      children: [
        Heading(text: title),
        const SizedBox(height: 20),
        P(text: description),
      ],
    );
  }
}
