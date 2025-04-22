import 'package:flutter/material.dart';

class BasePageScaffold extends StatelessWidget {
  final double spacing;
  final List<Widget> children;

  const BasePageScaffold({
    super.key,
    this.spacing = 48.0,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(spacing: 48.0, children: children),
      ),
    );
  }
}
