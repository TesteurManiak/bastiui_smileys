import 'package:flutter/material.dart';

/// Made by Aloïs Deniel: https://dartpad.dev/?id=1c6ebcd140a168d77776903101ce8fc9
class EyeCurve extends Curve {
  final Duration period;
  final Duration blinking;

  const EyeCurve({required this.period, required this.blinking});

  @override
  double transformInternal(double t) {
    final blinkingDuration = blinking.inMilliseconds / period.inMilliseconds;
    final startBlinking = 1.0 - blinkingDuration;
    if (t >= 1 || t < startBlinking) {
      return 1;
    }
    final relativeTime = (t - startBlinking) / blinkingDuration;
    if (relativeTime < 0.5) {
      return 1 - Curves.easeOut.transform(relativeTime * 2);
    }

    return Curves.easeIn.transform((relativeTime - 0.5) * 2);
  }
}
