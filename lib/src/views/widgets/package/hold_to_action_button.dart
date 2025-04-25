import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ButtonVariant { filled, outlined }

class HoldToActionButton extends StatefulWidget {
  /// Creates a button that triggers an action when held down for a specified duration.
  ///
  /// The button displays a progress fill that indicates the remaining time
  ///
  /// inspired from Emil Kowaski (https://emilkowal.ski/ui/building-a-hold-to-delete-component)
  const HoldToActionButton({
    super.key,
    this.duration = const Duration(seconds: 2),
    this.reverseDuration = const Duration(milliseconds: 200),
    this.onHoldComplete,
    this.text = 'Hold to Action',
    this.icon = const Icon(Icons.touch_app),
    this.textStyle,
    this.backgroundColor,
    this.progressColor = const Color(0xFFffdbdc),
    this.overlayTextColor = const Color(0xFFe5484d),
    this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.borderRadius = const BorderRadius.all(Radius.circular(50)),
    this.minWidth,
    this.maxWidth,
    this.variant = ButtonVariant.filled,
  });

  /// The duration of the hold before the action is triggered
  ///
  /// Defaults to 2 seconds
  final Duration duration;

  /// The duration of the reverse animation
  ///
  /// Defaults to 200 milliseconds
  final Duration reverseDuration;

  /// The callback to be called when the hold is complete
  ///
  /// This is where you can perform the action you want to trigger
  final VoidCallback? onHoldComplete;

  /// The text to be displayed on the button
  ///
  /// Defaults to 'Hold to Action'
  final String text;

  /// The text style to be applied to the button text
  ///
  final TextStyle? textStyle;

  /// The icon to be displayed on the button
  ///
  /// Defaults to [Icons.touch_app]
  final Icon icon;

  /// The background color of the button
  ///
  /// If not provided, the button will use the primary color of the theme
  final Color? backgroundColor;

  /// The color of the progress fill
  ///
  /// Defaults to [0xFFffdbdc]
  final Color progressColor;

  /// The color of the overlay text
  ///
  /// Defaults to [0xFFe5484d]
  final Color overlayTextColor;

  /// The color of the text
  ///
  /// If not provided, the button will use the onPrimary color of the theme
  final Color? textColor;

  /// The padding to be applied to the button
  ///
  /// Defaults to [EdgeInsets.symmetric(horizontal: 24, vertical: 12)]
  final EdgeInsetsGeometry padding;

  /// The border radius of the button
  ///
  /// Defaults to [BorderRadius.all(Radius.circular(50))]
  final BorderRadius borderRadius;

  /// The minimum width of the button
  ///
  /// If not provided, the button will fit to its content
  final double? minWidth;

  /// The maximum width of the button
  ///
  /// If not provided, the button will fit to its content
  final double? maxWidth;

  /// The variant of the button
  ///
  /// Defaults to [ButtonVariant.filled]
  ///
  /// The button can be either [ButtonVariant.filled] or [ButtonVariant.outlined]
  final ButtonVariant variant;

  @override
  State<HoldToActionButton> createState() => _HoldToActionButtonState();
}

class _HoldToActionButtonState extends State<HoldToActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _curvedValue;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
    );

    _curvedValue = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
      reverseCurve: Curves.easeOut,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        HapticFeedback.mediumImpact();
        log("✅ Hold complete — perform delete or other action");
        widget.onHoldComplete?.call();
        _controller.reset();
        setState(() => _isPressed = false);
      }
    });
  }

  void _startHold() {
    log("🔴 Pointer down — starting animation");
    setState(() => _isPressed = true);
    HapticFeedback.lightImpact();
    _controller.forward(from: 0.0);
  }

  void _cancelHold() {
    if (_controller.isCompleted) return;
    log("⚪ Pointer up — cancelling animation");
    _controller.reverse();
    setState(() => _isPressed = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _resolveTextColor(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.textColor != null) return widget.textColor!;

    return widget.variant == ButtonVariant.outlined
        ? theme.colorScheme.primary
        : theme.colorScheme.onPrimary;
  }

  Widget get _content => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      widget.icon,
      const SizedBox(width: 8),
      Text(
        widget.text,
        style:
            widget.textStyle != null
                ? widget.textStyle?.copyWith(color: widget.textColor)
                : TextStyle(
                  color: widget.textColor,

                  fontWeight: FontWeight.bold,
                ),
      ),
    ],
  );

  Widget _buildShadedContent(double progress, Color textColor) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [progress, progress],
          colors: [widget.overlayTextColor, textColor],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Padding(padding: widget.padding, child: _content),
    );
  }

  Widget _buildProgressFill() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        border:
            widget.variant == ButtonVariant.outlined
                ? Border.all(
                  color:
                      widget.textColor ?? Theme.of(context).colorScheme.primary,
                )
                : null,
      ),
      child: AnimatedBuilder(
        animation: _curvedValue,
        builder: (_, __) {
          return ClipRRect(
            borderRadius: widget.borderRadius,

            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: _curvedValue.value,
                child: Container(
                  decoration: BoxDecoration(color: widget.progressColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveTextColor = _resolveTextColor(context);

    final bgColor = widget.backgroundColor ?? theme.colorScheme.primary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Listener(
        onPointerDown: (_) => _startHold(),
        onPointerUp: (_) => _cancelHold(),

        child: AnimatedScale(
          scale: _isPressed ? 0.97 : 1.0,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: widget.minWidth ?? 0,
              maxWidth: widget.maxWidth ?? double.infinity,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: widget.padding,
                  decoration: BoxDecoration(
                    color:
                        widget.variant == ButtonVariant.filled
                            ? bgColor
                            : Colors.transparent,
                    borderRadius: widget.borderRadius,
                    border:
                        widget.variant == ButtonVariant.outlined
                            ? Border.all(
                              color:
                                  widget.textColor ??
                                  Theme.of(context).colorScheme.primary,
                            )
                            : null,
                  ),

                  child: _content,
                ),
                Positioned.fill(child: _buildProgressFill()),
                AnimatedBuilder(
                  animation: _curvedValue,
                  builder:
                      (_, __) => _buildShadedContent(
                        _curvedValue.value,
                        effectiveTextColor,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
