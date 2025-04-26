import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedIconLabelButton extends StatefulWidget {
  const AnimatedIconLabelButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.duration = const Duration(milliseconds: 200),
    this.textStyle,
    this.iconColor,
    this.spacing = 4.0,
    this.direction = AxisDirection.right,
    this.isExapandedFirst = false,


    this.shrinkDelay = const Duration(seconds: 2),
    this.height = 28,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Duration duration;
  final TextStyle? textStyle;
  final Color? iconColor;
  final double spacing;
  final AxisDirection direction;

  final Duration shrinkDelay;
  final bool isExapandedFirst;
  final double height;

  @override
  State<AnimatedIconLabelButton> createState() =>
      _AnimatedIconLabelButtonState();
}

class _AnimatedIconLabelButtonState extends State<AnimatedIconLabelButton>
     {
  late bool _expanded;
  Timer? _shrinkTimer;

  @override
  void initState() {
    
    super.initState();
    _expanded = widget.isExapandedFirst;

    // Auto-collapse after delay
    _shrinkTimer = Timer(widget.shrinkDelay, () {
      if (mounted) {
        setState(() => _expanded = false);
      }
    });
  }

  void _setExpanded(bool value) {
    _shrinkTimer?.cancel(); // Cancel auto-shrink if hovering
    setState(() {
      _expanded = value;
    });
  }

  void _handleTap() {
    setState(() => _expanded = true);

    _shrinkTimer?.cancel();
    _shrinkTimer = Timer(widget.shrinkDelay, () {
      if (mounted) setState(() => _expanded = false);
    });

    widget.onTap();
  }

  @override
  void dispose() {
    _shrinkTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontal =
        widget.direction == AxisDirection.right ||
        widget.direction == AxisDirection.left;

    final iconAndLabel = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          widget.direction == AxisDirection.right
              ? _buildChildren(isHorizontal)
              : _buildChildren(isHorizontal).reversed.toList(),
    );

    return MouseRegion(
      onEnter: (_) => _setExpanded(true),
      onExit: (_) => _setExpanded(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedSize(
          duration: widget.duration,
          curve: Curves.easeInOut,
          alignment: Alignment.center,
          child: iconAndLabel,
        ),
      ),
    );
  }

  List<Widget> _buildChildren(bool isHorizontal) {
    return [
      Icon(widget.icon, color: widget.iconColor),
      SizedBox(
        height: widget.height, // consistent alignment with text
        child: AnimatedSwitcher(
          duration: widget.duration,
          transitionBuilder:
              (child, animation) => FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  axis: isHorizontal ? Axis.horizontal : Axis.vertical,
                  child: child,
                ),
              ),
          child:
              _expanded
                  ? Padding(
                    key: const ValueKey('label'),
                    padding: EdgeInsets.only(
                      left: isHorizontal ? widget.spacing : 0,
                      top: isHorizontal ? 0 : widget.spacing,
                    ),
                    child: Text(
                      widget.label,
                      style:
                          widget.textStyle ??
                          Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                  : const SizedBox.shrink(key: ValueKey('empty')),
        ),
      ),
    ];
  }
}
