import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/src/core/app_router.dart';
import 'package:portfolio/src/views/widgets/common/heading.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';

class HeroLogoWidget extends StatelessWidget {
  const HeroLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      hoverColor: Colors.transparent,
    
      onTap: () {
        context.goNamed(AppRoutes.home.name);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Heading(text: 'Harkirat Singh', isSelectable: false),
    
          P(
            text: 'Software Artisan',
            isSelectable: false,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
