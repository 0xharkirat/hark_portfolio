import 'package:flutter/material.dart';
import 'package:portfolio/src/models/sub_route_list_item.dart';
import 'package:portfolio/src/views/widgets/common/base_page_scaffold.dart';
import 'package:portfolio/src/views/widgets/common/contact.dart';
import 'package:portfolio/src/views/widgets/common/footer.dart';
import 'package:portfolio/src/views/widgets/common/header.dart';
import 'package:portfolio/src/views/widgets/common/hero_section.dart';

class SubLabPage extends StatelessWidget {
  const SubLabPage({super.key, required this.subLabId});

  final String subLabId;

  @override
  Widget build(BuildContext context) {
    final subLabData = labListItems.firstWhere(
      (element) => element.routeId == subLabId,
    );
    return BasePageScaffold(
      children: [
        const Header(),
        HeroSection(
          title: subLabData.heading,
          description: subLabData.description,
        ),
        const Contact(),
        const Footer(),
      ],
    );
  }
}
