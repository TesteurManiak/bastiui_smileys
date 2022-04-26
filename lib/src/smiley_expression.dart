import 'package:flutter/material.dart';

import 'face_painter.dart';

class SmileyExpression {
  /// Initial top offset of the face.
  final double topPos;

  /// Initial right offset of the face.
  final double rightPos;

  /// Color of the face.
  final Color color;

  /// [CustomPainter] that draws the face.
  final FacePainter _face;

  /// Duration before the smiley's animation is triggered.
  final Duration period;

  const SmileyExpression({
    required this.topPos,
    this.rightPos = 8.0,
    required this.color,
    required FacePainter facePainter,
    this.period = const Duration(seconds: 2),
  }) : _face = facePainter;

  static const verySad = SmileyExpression(
    topPos: 34,
    color: Color(0xFFFF603E),
    facePainter: VerySadFacePainter(),
    period: Duration(milliseconds: 1400),
  );

  static const sad = SmileyExpression(
    topPos: 28,
    color: Color(0xFFFF833E),
    facePainter: SadFacePainter(),
    period: Duration(milliseconds: 2400),
  );

  static const neutral = SmileyExpression(
    topPos: 24,
    color: Color(0xFFFFC061),
    facePainter: NeutralFacePainter(),
    period: Duration(milliseconds: 3200),
  );

  static const happy = SmileyExpression(
    topPos: 18,
    color: Color(0xFFFFD43E),
    facePainter: HappyFacePainter(),
    period: Duration(milliseconds: 4000),
  );

  static const veryHappy = SmileyExpression(
    topPos: 12,
    rightPos: 10,
    color: Color(0xFFFFED4E),
    facePainter: VeryHappyFacePainter(),
    period: Duration(milliseconds: 4800),
  );

  FacePainter createPainter(Animation<double> animation) =>
      _face.copyWith(eyeOpening: animation);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SmileyExpression &&
        other.topPos == topPos &&
        other.rightPos == rightPos &&
        other.color == color &&
        other._face == _face &&
        other.period == period;
  }

  @override
  int get hashCode {
    return topPos.hashCode ^
        rightPos.hashCode ^
        color.hashCode ^
        _face.hashCode ^
        period.hashCode;
  }
}
