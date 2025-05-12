import 'package:flutter/material.dart';

class RotateState {
  final String label;
  final IconData? icon; // Leading icon

  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;
  final String? semanticLabel;

  const RotateState({
    required this.label,
    this.icon,

    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.semanticLabel,
  });
}


class AnimatedRotateButton extends StatefulWidget {
  final List<RotateState> states;
  final int initialIndex;
  final Duration duration;
  final void Function(int index)? onChanged;
  final Widget? leadingFallback;
  final Widget? trailing;
  final double height;
  final double borderRadius;
  final int? changeIndexTo;

  const AnimatedRotateButton({
    super.key,
    required this.states,
    this.initialIndex = 0,
    this.duration = const Duration(milliseconds: 500),
    this.onChanged,
    this.leadingFallback,
    this.trailing,
    this.height = 50,
    this.borderRadius = 25.0,
    this.changeIndexTo,
  });

  @override
  State<AnimatedRotateButton> createState() =>
      _AnimatedRotateButtonState();
}

class _AnimatedRotateButtonState
    extends State<AnimatedRotateButton>
    with TickerProviderStateMixin {
  late int _currentIndex;
  late int _nextIndex;
  late AnimationController _controller;
  late Animation<Offset> _slideOut;
  late Animation<Offset> _slideIn;
  late Animation<double> _fadeOut;
  late Animation<double> _fadeIn;
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<Color?> _foregroundColorAnimation;

  bool _isAnimating = false;

  bool get _hasAnyIcon {
    return widget.states.any((s) => s.icon != null) || widget.leadingFallback != null;
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _nextIndex = _currentIndex;
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _setupAnimations();
  }

  void _setupAnimations() {
    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _slideOut = Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1)).animate(curve);
    _slideIn = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(curve);
    _fadeOut = Tween<double>(begin: 1, end: 0).animate(curve);
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(curve);

    final fromBg = widget.states[_currentIndex].backgroundColor ??
        (_currentIndex.isEven ? Colors.black12 : Colors.black);
    final toBg = widget.states[_nextIndex].backgroundColor ??
        (_nextIndex.isEven ? Colors.black12 : Colors.black);

    final fromFg = widget.states[_currentIndex].foregroundColor ??
        (_currentIndex.isEven ? Colors.black : Colors.white);
    final toFg = widget.states[_nextIndex].foregroundColor ??
        (_nextIndex.isEven ? Colors.black : Colors.white);

    _backgroundColorAnimation = ColorTween(begin: fromBg, end: toBg).animate(curve);
    _foregroundColorAnimation = ColorTween(begin: fromFg, end: toFg).animate(curve);
  }

  @override
  void didUpdateWidget(covariant AnimatedRotateButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.changeIndexTo != null &&
        widget.changeIndexTo != _currentIndex &&
        widget.changeIndexTo != _nextIndex) {
      changeCurrentState(widget.changeIndexTo!);
    }
  }

  void changeCurrentState(int index) {
    _animateTo(index);
  }

  Future<void> _animateTo(int index) async {
    if (_isAnimating ||
        index == _currentIndex ||
        index < 0 ||
        index >= widget.states.length) {
      return;
    }

    setState(() {
      _isAnimating = true;
      _nextIndex = index;
    });

    _setupAnimations();
    await _controller.forward(from: 0);

    setState(() {
      _currentIndex = index;
      _isAnimating = false;
    });
  }



  void _rotate() async {
    if (_isAnimating || widget.states.length < 2) return;

    setState(() {
      _isAnimating = true;
      _nextIndex = (_currentIndex + 1) % widget.states.length;
    });

    _setupAnimations(); // Reset transitions
    await _controller.forward(from: 0);

    setState(() {
      _currentIndex = _nextIndex;
      _isAnimating = false;
    });

    widget.onChanged?.call(_currentIndex);
  }

  Widget _buildIcon(Color foregroundColor) {
    final currentState = widget.states[_currentIndex];
    final nextState = widget.states[_nextIndex];

    final currentIcon = currentState.icon != null
        ? Icon(currentState.icon, key: ValueKey(currentState.icon), color: foregroundColor, size: 20)
        : widget.leadingFallback != null
            ? KeyedSubtree(key: const ValueKey('fallback'), child: widget.leadingFallback!)
            : const SizedBox.shrink(key: ValueKey('empty'));

    final nextIcon = nextState.icon != null
        ? Icon(nextState.icon, key: ValueKey(nextState.icon), color: foregroundColor, size: 20)
        : widget.leadingFallback != null
            ? KeyedSubtree(key: const ValueKey('fallback'), child: widget.leadingFallback!)
            : const SizedBox.shrink(key: ValueKey('empty'));

    final iconStack = Stack(
      alignment: Alignment.center,
      children: [
        if (_isAnimating)
          ScaleTransition(
            scale: Tween<double>(begin: 1.0, end: 0.8).animate(_controller),
            child: FadeTransition(opacity: _fadeOut, child: currentIcon),
          )
        else
          currentIcon,
        if (_isAnimating)
          ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(_controller),
            child: FadeTransition(opacity: _fadeIn, child: nextIcon),
          ),
      ],
    );

    return _hasAnyIcon
        ? SizedBox(width: 24, child: Center(child: iconStack))
        : iconStack;
  }

  Widget _buildAnimatedContent(Color fallbackColor) {
    final currentState = widget.states[_currentIndex];
    final nextState = widget.states[_nextIndex];

    final currentLabel = Text(
      currentState.label,
      key: ValueKey(currentState.label),
      style: currentState.textStyle ??
          TextStyle(color: fallbackColor, fontWeight: FontWeight.w500),
    );

    final nextLabel = Text(
      nextState.label,
      key: ValueKey(nextState.label),
      style: nextState.textStyle ??
          TextStyle(color: fallbackColor, fontWeight: FontWeight.w500),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4.0,
      children: [
        _buildIcon(fallbackColor),
        AnimatedSize(
          duration: widget.duration,
          curve: Curves.easeInOutCubic,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_isAnimating)
                SlideTransition(
                  position: _slideOut,
                  child: FadeTransition(opacity: _fadeOut, child: currentLabel),
                )
              else
                currentLabel,
              if (_isAnimating)
                SlideTransition(
                  position: _slideIn,
                  child: FadeTransition(opacity: _fadeIn, child: nextLabel),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final currentState = widget.states[_currentIndex];

        final background = _isAnimating
            ? _backgroundColorAnimation.value
            : currentState.backgroundColor ??
                (_currentIndex.isEven ? Colors.black12 : Colors.black);

        final foreground = _isAnimating
            ? _foregroundColorAnimation.value
            : currentState.foregroundColor ??
                (_currentIndex.isEven ? Colors.black : Colors.white);

        return InkWell(
          onTap: _rotate,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Container(
            height: widget.height,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4.0,
              children: [
                ClipRect(child: _buildAnimatedContent(foreground ?? Colors.black)),
                if (widget.trailing != null)
                  DefaultTextStyle(
                    style: currentState.textStyle ??
                        TextStyle(color: foreground, fontWeight: FontWeight.w500),
                    child: widget.trailing!,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
