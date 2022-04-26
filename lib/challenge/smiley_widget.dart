import 'package:flutter/material.dart';

import 'eye_curve.dart';
import 'smiley_expression.dart';

const kDefaultSmileySize = 56.0;

class SmileyWidget extends StatefulWidget {
  final double size;
  final SmileyExpression expression;
  final bool isSelected;
  final bool isEnabled;
  final void Function()? onSelected;

  const SmileyWidget({
    Key? key,
    required this.expression,
    this.size = kDefaultSmileySize,
    this.isSelected = false,
    this.isEnabled = true,
    this.onSelected,
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
          height: widget.isSelected ? widget.size * 1.2 : widget.size,
          width: widget.isSelected ? widget.size * 1.2 : widget.size,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: widget.onSelected,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: widget.size,
                  height: widget.size,
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
                  height: widget.size,
                  width: widget.size,
                  top: widget.expression.topPos,
                  right: _isHovering || widget.isSelected
                      ? widget.size / 2 -
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
