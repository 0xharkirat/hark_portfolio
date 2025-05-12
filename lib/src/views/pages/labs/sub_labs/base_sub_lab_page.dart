import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portfolio/src/models/sub_route_list_item.dart';
import 'package:portfolio/src/views/pages/labs/sub_labs/animated_switcher_lab.dart';
import 'package:portfolio/src/views/pages/labs/sub_labs/hold_to_action_button_lab.dart';
import 'package:portfolio/src/views/pages/labs/sub_labs/rough_notation_lab.dart';
import 'package:portfolio/src/views/widgets/common/base_page_scaffold.dart';
import 'package:portfolio/src/views/widgets/common/contact.dart';
import 'package:portfolio/src/views/widgets/common/footer.dart';
import 'package:portfolio/src/views/widgets/common/header.dart';
import 'package:portfolio/src/views/widgets/home/hero_section.dart';

class BaseSubLabPage extends StatelessWidget {
  const BaseSubLabPage({super.key, required this.subLabId});

  final String subLabId;

  Widget _getLabContent(LabSubRoute route) {
    switch (route) {
      case LabSubRoute.holdToActionButton:
        return const HoldToActionButtonLab();
      case LabSubRoute.roughNotation:
        return const RoughNotationLab();
      case LabSubRoute.animatedSwitchToggleButton:
        return const AnimatedSwitcherLab();
      default:
        return const Center(child: Text('Lab content not available'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeEnum = LabSubRoute.fromRouteId(subLabId);

    final subLabData = labListItems.firstWhere(
      (element) => element.routeId == subLabId,
    );

    return BasePageScaffold(
      children: [
        const Header(),
        HeroSection(
          title: subLabData.heading,
          description: subLabData.description,
          outerPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        _getLabContent(routeEnum),
        const Contact(),
        const Footer(),
      ],
    );
  }
}
