import 'package:flutter/material.dart';
import 'package:portfolio/src/models/list_item.dart';
import 'package:portfolio/src/views/widgets/common/base_list_section.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ContributionsSection extends StatelessWidget {
  const ContributionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseListSection<ListItem>(
      title: 'Contributions',
      listItems: contributionListItems,
      headingIcon: LucideIcons.gitPullRequestArrow,
    );
  }
}
