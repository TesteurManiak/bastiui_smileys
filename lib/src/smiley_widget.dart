import 'package:flutter/material.dart';

import 'eye_curve.dart';
import 'smiley_expression.dart';

const kDefaultSmileySize = 56.0;

class SmileyWidget extends StatefulWidget {
  /// The expression of the smiley.
  final SmileyExpression expression;

  /// Selection state of the widget. By default it is `false`.
  ///
  /// If `true` the widget will be drawn with a white border.
  final bool isSelected;

  /// Define if the widget is enabled or not. By default it is `true`.
  ///
  /// If `false` the widget will be drawn with a `0.5` opacity.
  final bool isEnabled;

  /// Callback triggered when the widget is tapped on.
  final VoidCallback? onTap;

  /// Create a widget which draws an animated smiley face.
  const SmileyWidget({
    Key? key,
    required this.expression,
    this.isSelected = false,
    this.isEnabled = true,
    this.onTap,
  }) : super(key: key);

  @override
  State<SmileyWidget> createState() => _SmileyWidgetState();
}

class _SmileyWidgetState extends State<SmileyWidget>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: widget.expression.period,
  );

  late final Animation<double> _openingAnimation = CurvedAnimation(
    parent: _controller,
    curve: EyeCurve(
      period: widget.expression.period,
      blinking: const Duration(milliseconds: 500),
    ),
  );

  bool _isHovering = false;

  bool get _isVeryHappy => widget.expression == SmileyExpression.veryHappy;

  @override
  void initState() {
    super.initState();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (_) => setState(() => _isHovering = false),
      onEnter: (_) => setState(() => _isHovering = true),
      child: AnimatedOpacity(
        opacity: widget.isSelected || widget.isEnabled ? 1 : 0.5,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          height:
              widget.isSelected ? kDefaultSmileySize * 1.2 : kDefaultSmileySize,
          width:
              widget.isSelected ? kDefaultSmileySize * 1.2 : kDefaultSmileySize,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: kDefaultSmileySize,
                  height: kDefaultSmileySize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.expression.color,
                    boxShadow: [
                      if (!widget.isSelected)
                        const BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                    ],
                  ),
                  foregroundDecoration: const BoxDecoration(
                    backgroundBlendMode: BlendMode.overlay,
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color.fromRGBO(0, 0, 0, 1),
                        Color.fromRGBO(255, 255, 255, 1),
                      ],
                      center: Alignment.bottomLeft,
                      radius: 1.8,
                    ),
                  ),
                ),
                AnimatedPositioned(
                  height: kDefaultSmileySize,
                  width: kDefaultSmileySize,
                  top: widget.expression.topPos,
                  right: _isHovering || widget.isSelected
                      ? kDefaultSmileySize / 2 -
                          widget.expression.rightPos *
                              (_isVeryHappy ? 1.4 : 1.8)
                      : widget.expression.rightPos,
                  duration: const Duration(milliseconds: 200),
                  child: CustomPaint(
                    painter: widget.expression.createPainter(_openingAnimation),
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
