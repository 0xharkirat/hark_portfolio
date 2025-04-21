import 'package:flutter/material.dart';
import 'package:portfolio/src/models/list_item.dart';
import 'package:portfolio/src/views/widgets/base_list_section.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseListSection(title: "Projects", listItems: projectListItems);
  }
}
