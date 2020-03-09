import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dark_fast_switcher_state.dart';

class DarkFastSwitcherController extends ChangeNotifier {
  static const int durationDefault = 350; //Default animation duration (milisec)
  static const double valueStart = 0.0; //Default start value
  static const double valueEnd = 1.0; //Default end value

  final AnimationController controller;
  Animation colorTween;

  DarkFastSwitcherState state = DarkFastSwitcherState.on;
  DarkFastSwitcherState prevState = DarkFastSwitcherState.on;

  double get progress => controller.value;

  DarkFastSwitcherController({@required TickerProvider vsync, this.state})
      : controller = AnimationController(vsync: vsync) {
    controller.addListener(_onStateUpdate);
    prevState = state;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onStateUpdate() {
    notifyListeners();
  }

  void _startAnimation(double animationTo) {
    controller
      ..duration = const Duration(milliseconds: durationDefault)
      ..animateTo(animationTo);
    notifyListeners();
  }

  void setSwitchOnState() {
    _startAnimation(valueStart);
    state = DarkFastSwitcherState.on;
  }

  void setSwitchOffState() {
    _startAnimation(valueEnd);
    state = DarkFastSwitcherState.off;
  }
}
