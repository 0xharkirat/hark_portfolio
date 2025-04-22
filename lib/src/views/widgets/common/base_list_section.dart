import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/src/core/app_router.dart';
import 'package:portfolio/src/models/list_item.dart';
import 'package:portfolio/src/models/sub_route_list_item.dart';
import 'package:portfolio/src/utils/methods.dart';
import 'package:portfolio/src/views/widgets/common/heading.dart';
import 'package:portfolio/src/views/widgets/common/li.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';
import 'package:portfolio/src/views/widgets/common/section.dart';

class BaseListSection<T> extends StatelessWidget {
  const BaseListSection({
    super.key,
    required this.title,
    required this.listItems,
  });
  final String title;
  final List<T> listItems;

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
            if (listItem is ListItem) {
              return LI(
                heading: Heading(text: listItem.heading, isSelectable: false),
                p: P(text: listItem.description, isSelectable: false),
                onTap: () {
                  if (listItem.url != null) {
                    linkOpen(listItem.url!);
                  }
                },
              );
            } else if (listItem is SubRouteListItem) {
              return LI(
                heading: Heading(text: listItem.heading, isSelectable: false),
                p: P(text: listItem.description, isSelectable: false),
                onTap: () {
                  context.goNamed(
                    AppRoutes.subLab.name,
                    pathParameters: {
                      'subLabId': listItem.routeId,
                    },
                  );
                },
              );
            } else {
              return P(text: 'Unsupported item type', isSelectable: false);
            }
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
        ),
      ],
    );
  }
}
