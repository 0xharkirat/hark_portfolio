import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/src/core/app_router.dart';
import 'package:portfolio/src/models/list_item.dart';
import 'package:portfolio/src/models/sub_route_list_item.dart';
import 'package:portfolio/src/utils/methods.dart';
import 'package:portfolio/src/utils/string_extension.dart';
import 'package:portfolio/src/views/widgets/common/heading.dart';
import 'package:portfolio/src/views/widgets/common/li.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';
import 'package:portfolio/src/views/widgets/common/section.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BaseListSection<T> extends StatefulWidget {
  const BaseListSection({
    super.key,
    required this.title,
    required this.listItems,
    this.moreText,
    this.headingIcon,
    this.animate = true,
    this.animationIndex = 0,
  });

  final String title;
  final List<T> listItems;
  final String? moreText;
  final IconData? headingIcon;
  final bool animate;
  final int animationIndex;

  @override
  State<BaseListSection<T>> createState() => _BaseListSectionState<T>();
}

class _BaseListSectionState<T> extends State<BaseListSection<T>> {
  bool isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = ShadTheme.of(context).textTheme.p.copyWith(
      fontSize: 16,
      color:
          isExpanded
              ? ShadTheme.of(context).colorScheme.secondary
              : ShadTheme.of(context).colorScheme.primary,
      fontWeight: FontWeight.w500,
    );

    final iconColor =
        isExpanded
            ? ShadTheme.of(context).colorScheme.secondary
            : ShadTheme.of(context).colorScheme.primary;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.listItems.length,
          itemBuilder: (context, index) {
            final item = widget.listItems[index];
            if (item is ListItem) {
              return LI(
                heading: Heading(text: item.heading, isSelectable: false),
                p: P(text: item.description, isSelectable: false),
                onTap: () {
                  if (item.url != null) linkOpen(item.url!);
                },
              );
            } else if (item is SubRouteListItem) {
              return LI(
                heading: Heading(text: item.heading, isSelectable: false),
                p: P(text: item.description, isSelectable: false),
                onTap: () {
                  switch (item.type) {
                    case RouteType.subPoem:
                      context.goNamed(
                        AppRoutes.subPoem.name,
                        pathParameters: {
                          PathParams.subPoemId.name: item.routeId,
                        },
                      );
                      break;
                    case RouteType.subLab:
                      context.goNamed(
                        AppRoutes.subLab.name,
                        pathParameters: {
                          PathParams.subLabId.name: item.routeId,
                        },
                      );
                      break;
                  }
                },
              );
            } else {
              return P(text: 'Unsupported item type', isSelectable: false);
            }
          },
          separatorBuilder: (_, __) => const SizedBox(height: 16),
        ),
        if (widget.moreText != null) ...[
          const SizedBox(height: 20),
          P(text: widget.moreText!),
        ],
        const SizedBox(height: 48),
      ],
    );

    return Section(
      outerPadding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Transform.translate(
          offset: const Offset(-16, 0),
          child: ShadButton.ghost(
            size: ShadButtonSize.sm,
            onPressed: widget.animate ? _toggleExpanded : null,

            leading: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeInOutCubic,
              switchOutCurve: Curves.easeOutCubic,
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child:
                  isExpanded
                      ? Icon(
                        LucideIcons.undo2,
                        key: const ValueKey('undo'),
                        color: iconColor,
                      )
                      : Icon(
                        widget.headingIcon,
                        key: const ValueKey('box'),
                        color: iconColor,
                      ).withStagger(widget.animationIndex),
            ),
            child: Heading(
              text: widget.title,
              textStyle: style,
              isSelectable: false,
            ),
          ),
        ),

        const SizedBox(height: 12),
        widget.animate
            ? AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeInOutCubic,
              switchOutCurve: Curves.easeOutCubic,
              transitionBuilder: (child, animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(0, 0.1),
                  end: Offset.zero,
                ).animate(animation);
                return SlideTransition(position: offsetAnimation, child: child);
              },
              child:
                  isExpanded
                      ? Container(
                        key: const ValueKey('expanded'),
                        child: content,
                      )
                      : const SizedBox.shrink(key: ValueKey('collapsed')),
            )
            : content,
      ],
    );
  }
}
