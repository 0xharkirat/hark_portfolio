const holdToActionButtonCode = '''
// hold_to_action_button.dart
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
''';

const holdToActionButtonExampleCode = '''
// main.dart (full example)
import 'package:flutter/material.dart';
import 'hold_to_action_button.dart'; // assuming that your HoldToActionButton is in the same directory

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hold to Action Button Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HoldToActionButtonExample(),
    );
  }
}

class HoldToActionButtonExample extends StatefulWidget {
  const HoldToActionButtonExample({super.key});

  @override
  State<HoldToActionButtonExample> createState() =>
      _HoldToActionButtonExampleState();
}

class _HoldToActionButtonExampleState extends State<HoldToActionButtonExample> {

  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hold to Action Button Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HoldToActionButton(
              
              icon: const Icon(Icons.add),
              text: 'Hold to Increment',
              onHoldComplete: _incrementCounter,
            ),
            const SizedBox(height: 32),
            Text('Counter: \$_counter'),
          ],
        ),
      ),
    );
  }
}
''';

const animatedRotateButtonCode = '''
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

''';

const animatedRotateButtonExampleCode = '''
import 'package:flutter/material.dart';
import 'animated_rotate_button.dart'; // assuming that your AnimatedRotateButton is in the same directory


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

enum AppThemeMode {
  system(ThemeMode.system, Icons.laptop),
  light(ThemeMode.light, Icons.light_mode),
  dark(ThemeMode.dark, Icons.dark_mode);

  final ThemeMode mode;
  final IconData icon;
  const AppThemeMode(this.mode, this.icon);
}


class _MyAppState extends State<MyApp> {
  AppThemeMode _themeMode = AppThemeMode.system;

  void _changeThemeMode(int index) {
    setState(() {
      _themeMode = AppThemeMode.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Toggle Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode.mode,
      home: ThemeHomePage(
        currentMode: _themeMode,
        onModeChanged: _changeThemeMode,
      ),
    );
  }
}

class ThemeHomePage extends StatelessWidget {
  final AppThemeMode currentMode;
  final void Function(int index) onModeChanged;

  const ThemeHomePage({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = AppThemeMode.values.indexOf(currentMode);

    return Scaffold(
      appBar: AppBar(title: const Text('Theme Toggle Button')),
      body: Center(
        child: AnimatedRotateButton(
          states:
              AppThemeMode.values
                  .map(
                    (e) => RotateState(
                      label: e.name,
                      icon: e.icon,
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      foregroundColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  )
                  .toList(),
          changeIndexTo: currentIndex,
          onChanged: onModeChanged,
        ),
      ),
    );
  }
}


''';
