import 'dart:math' as math;

import 'package:flutter/material.dart';

const _kDefaultEyeSize = 4.0;

abstract class FacePainter extends CustomPainter {
  final double eyeSize;
  final Animation<double>? eyeOpening;

  const FacePainter({this.eyeSize = _kDefaultEyeSize, this.eyeOpening})
      : super(repaint: eyeOpening);

  @override
  bool shouldRepaint(covariant FacePainter oldDelegate) => false;

  FacePainter copyWith({Animation<double>? eyeOpening});
}

class VerySadFacePainter extends FacePainter {
  const VerySadFacePainter({Animation<double>? eyeOpening})
      : super(eyeOpening: eyeOpening);

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..drawEyes(size: size, eyeSize: eyeSize, opening: eyeOpening?.value)
      ..drawSadMouth(size: size, eyeSize: eyeSize);

    final eyebrowPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final leftEyebrowPath = Path()
      ..moveTo(size.width + eyeSize * 1.5, -8.5)
      ..lineTo(size.width - eyeSize * 1.3, -4.5)
      ..close();

    final rightEyebrowPath = Path()
      ..moveTo(size.width - eyeSize * 7.5, -8.5)
      ..lineTo(size.width - 24 + eyeSize * 1.3, -4.5)
      ..close();

    canvas
      ..drawPath(leftEyebrowPath, eyebrowPaint)
      ..drawPath(rightEyebrowPath, eyebrowPaint);
  }

  @override
  FacePainter copyWith({Animation<double>? eyeOpening}) {
    return VerySadFacePainter(eyeOpening: eyeOpening);
  }
}

class SadFacePainter extends FacePainter {
  const SadFacePainter({Animation<double>? eyeOpening})
      : super(eyeOpening: eyeOpening);

  @override
  void paint(Canvas canvas, Size size) {
    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas
      ..drawEyes(size: size, eyeSize: eyeSize, opening: eyeOpening?.value)
      ..drawArc(
        Rect.fromCenter(
          center: Offset(size.width - 13, eyeSize * 2),
          width: 10,
          height: 10,
        ),
        math.pi,
        math.pi,
        false,
        mouthPaint,
      );
  }

  @override
  FacePainter copyWith({Animation<double>? eyeOpening}) =>
      SadFacePainter(eyeOpening: eyeOpening);
}

class NeutralFacePainter extends FacePainter {
  const NeutralFacePainter({Animation<double>? eyeOpening})
      : super(eyeOpening: eyeOpening);

  @override
  void paint(Canvas canvas, Size size) {
    final mouthPaint = Paint()..color = Colors.black;

    canvas
      ..drawEyes(size: size, eyeSize: eyeSize, opening: eyeOpening?.value)
      ..drawRect(
        Rect.fromLTWH(size.width - 21, eyeSize, 16, 4),
        mouthPaint,
      );
  }

  @override
  FacePainter copyWith({Animation<double>? eyeOpening}) => NeutralFacePainter(
        eyeOpening: eyeOpening,
      );
}

class HappyFacePainter extends FacePainter {
  const HappyFacePainter({Animation<double>? eyeOpening})
      : super(eyeOpening: eyeOpening);

  @override
  void paint(Canvas canvas, Size size) {
    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas
      ..drawEyes(size: size, eyeSize: eyeSize, opening: eyeOpening?.value)
      ..drawArc(
        Rect.fromCenter(
          center: Offset(size.width - 13, eyeSize),
          width: 10,
          height: 10,
        ),
        0,
        math.pi,
        false,
        mouthPaint,
      );
  }

  @override
  FacePainter copyWith({Animation<double>? eyeOpening}) => HappyFacePainter(
        eyeOpening: eyeOpening,
      );
}

class VeryHappyFacePainter extends FacePainter {
  const VeryHappyFacePainter({Animation<double>? eyeOpening})
      : super(eyeOpening: eyeOpening);

  @override
  void paint(Canvas canvas, Size size) {
    final mouthPaint = Paint()..color = Colors.black;
    canvas
      ..drawEyes(size: size, eyeSize: eyeSize, opening: eyeOpening?.value)
      ..drawArc(
        Rect.fromCenter(
          center: Offset(size.width - 13, eyeSize),
          width: 16,
          height: 16,
        ),
        0,
        math.pi,
        false,
        mouthPaint,
      );
  }

  @override
  FacePainter copyWith({Animation<double>? eyeOpening}) => VeryHappyFacePainter(
        eyeOpening: eyeOpening,
      );
}

extension on Canvas {
  void drawEyes({
    required Size size,
    required double eyeSize,
    required double? opening,
  }) {
    final eyePaint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round;

    final point1 = Offset(size.width - 24 - eyeSize / 2, 0);
    final point2 = Offset(size.width, 0);

    final leftEyePath = Path();
    if (opening != null && opening < 1) {
      leftEyePath.addOval(
        Rect.fromCenter(
          center: point1,
          width: eyeSize * 2,
          height: eyeSize * 2 * opening,
        ),
      );
    } else {
      leftEyePath.addOval(Rect.fromCircle(center: point1, radius: eyeSize));
    }

    final rightEyePath = Path();
    if (opening != null && opening < 1) {
      rightEyePath.addOval(
        Rect.fromCenter(
          center: point2,
          width: eyeSize * 2,
          height: eyeSize * 2 * opening,
        ),
      );
    } else {
      rightEyePath.addOval(Rect.fromCircle(center: point2, radius: eyeSize));
    }

    this
      ..drawPath(leftEyePath, eyePaint)
      ..drawPath(rightEyePath, eyePaint);
  }

  void drawSadMouth({required Size size, required double eyeSize}) {
    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    drawArc(
      Rect.fromCenter(
        center: Offset(size.width - 13, eyeSize * 2),
        width: 10,
        height: 10,
      ),
      math.pi,
      math.pi,
      false,
      mouthPaint,
    );
  }
}
