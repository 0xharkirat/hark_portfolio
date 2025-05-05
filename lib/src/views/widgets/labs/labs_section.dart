import 'package:flutter/material.dart';
import 'package:portfolio/src/models/sub_route_list_item.dart';
import 'package:portfolio/src/views/widgets/common/base_list_section.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LabsSection extends StatelessWidget {
  const LabsSection({super.key, required this.animate});
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return BaseListSection<SubRouteListItem>(
      title: "Labs",
      listItems: labListItems,
      moreText: "Cooking more labs...",
      headingIcon: LucideIcons.blocks,
      animate: animate,
      animationIndex: 0,
    );
  }
}
