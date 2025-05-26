import 'package:flutter/material.dart';
import 'package:portfolio/src/models/poems.dart';
import 'package:portfolio/src/models/sub_route_list_item.dart';
import 'package:portfolio/src/views/widgets/common/base_page_scaffold.dart';
import 'package:portfolio/src/views/widgets/common/contact.dart';
import 'package:portfolio/src/views/widgets/common/footer.dart';
import 'package:portfolio/src/views/widgets/common/header.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';
import 'package:portfolio/src/views/widgets/common/section.dart';
import 'package:portfolio/src/views/widgets/home/hero_section.dart';

class BaseSubPoemPage extends StatelessWidget {
  const BaseSubPoemPage({super.key, required this.subPoemId});

  final String subPoemId;

  String _getPoemContent(PoemSubRoute route) {
    switch (route) {
      case PoemSubRoute.girlOnTheTrain:
        return kGirlOnTheTrain;
      default:
        return 'No content available for this poem.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeEnum = PoemSubRoute.fromRouteId(subPoemId);

    final subPoemData = poemListItems.firstWhere(
      (element) => element.routeId == subPoemId,
    );

    return BasePageScaffold(
      spacing: 20,
      children: [
        const Header(),
        HeroSection(
          title: subPoemData.heading,
          description: subPoemData.description,
          outerPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        // _getPoemContent(),
        Section(
          outerPadding: const EdgeInsets.symmetric(horizontal: 16),
          children: [P(text: _getPoemContent(routeEnum))],
        ),
        const Contact(),
        const Footer(),
      ],
    );
  }
}
