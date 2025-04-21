import 'package:flutter/material.dart';
import 'package:portfolio/src/models/list_item.dart';
import 'package:portfolio/src/views/widgets/base_list_section.dart';

class ContributionsSection extends StatelessWidget {
  const ContributionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseListSection(title: 'Open-Source Contributions', listItems: contributionListItems);
  }
}