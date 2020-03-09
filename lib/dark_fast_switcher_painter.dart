import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dark_fast_switcher_state.dart';

class DarkFastPainter extends CustomPainter {
  final double animationStep;
  final DarkFastSwitcherState sliderState;

  final double heightToRadiusRatio;
  final Color pureColor;
  final Color darkColor;

  static const double animationOffset = 0.5; //Offset for animation

  DarkFastPainter(this.animationStep, this.sliderState,
      {this.darkColor, this.pureColor, this.heightToRadiusRatio});

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height / 2;
    final width = size.width;
    final radius = height * (1 - heightToRadiusRatio);
    final paintDark = _paintBuilder(darkColor);
    final paintPure = _paintBuilder(pureColor);

    if (sliderState == DarkFastSwitcherState.on) {
      final rb = radius + (width - radius) * 2 * animationStep;
      final rc = radius * 2 * (animationStep - animationOffset);
      if (animationStep < animationOffset) {
        _paintBackground(canvas, size, paintDark);
        _paintAnimationCircle(canvas, rb, height, paintPure, width - height);
        _paintBackground(canvas, size, paintPure);
      } else if (animationStep >= animationOffset) {
        _paintBackground(canvas, size, paintPure);
        _paintCircle(canvas, rc, height, paintDark, height);
      }
    } else {
      final rb = radius + (width - radius) * 2 * (1 - animationStep);
      final rc = radius * 2 * (animationOffset - animationStep);
      if (1 - animationStep < animationOffset) {
        _paintBackground(canvas, size, paintPure);
        _paintAnimationCircle(canvas, rb, height, paintDark, height);
        _paintBackground(canvas, size, paintDark);
      } else if (1 - animationStep >= animationOffset) {
        _paintBackground(canvas, size, paintDark);
        _paintCircle(canvas, rc, height, paintPure, width - height);
      }
    }
  }

  @override
  bool shouldRepaint(DarkFastPainter oldDelegate) => true;

  void _paintBackground(Canvas canvas, Size size, Paint paintSun) {
    final radiusCircle = size.height / 2;

    final path = Path()
      ..moveTo(radiusCircle, 0)
      ..lineTo(size.width - radiusCircle, 0)
      ..arcToPoint(Offset(size.width - radiusCircle, size.height),
          radius: Radius.circular(radiusCircle), clockwise: true)
      ..lineTo(radiusCircle, size.height)
      ..arcToPoint(Offset(radiusCircle, 0),
          radius: Radius.circular(radiusCircle), clockwise: true);

    canvas.drawPath(path, paintSun);
  }

  void _paintCircle(
      Canvas canvas, double radius, double height, Paint paint, double offset) {
    canvas.drawCircle(Offset(offset, height), radius, paint);
  }

  void _paintAnimationCircle(
      Canvas canvas, double radius, double height, Paint paint, double offset) {
    final circularPath = Path()
      ..addOval(
          Rect.fromCircle(center: Offset(offset, height), radius: radius));
    canvas.clipPath(circularPath, doAntiAlias: false);
  }

  Paint _paintBuilder(Color color) => Paint()
    ..color = color
    ..style = PaintingStyle.fill;
}
