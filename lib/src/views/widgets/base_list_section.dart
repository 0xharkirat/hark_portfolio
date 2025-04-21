import 'package:flutter/material.dart';
import 'package:portfolio/src/models/list_item.dart';
import 'package:portfolio/src/utils/methods.dart';
import 'package:portfolio/src/views/widgets/heading.dart';
import 'package:portfolio/src/views/widgets/li.dart';
import 'package:portfolio/src/views/widgets/p.dart';
import 'package:portfolio/src/views/widgets/section.dart';

class BaseListSection extends StatelessWidget {
  const BaseListSection({
    super.key,
    required this.title,
    required this.listItems,
  });
  final String title;
  final List<ListItem> listItems;

  @override
  Widget build(BuildContext context) {
    return Section(
      children: [
        Heading(text: title),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listItems.length,
          itemBuilder: (context, index) {
            final listItem = listItems[index];
            return LI(
              heading: Heading(text: listItem.heading, isSelectable: false),
              p: P(text: listItem.description, isSelectable: false),
              onTap: () {
                if (listItem.url != null) {
                  linkOpen(listItem.url!);
                }
              },
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
        ),
      ],
    );
  }
}

