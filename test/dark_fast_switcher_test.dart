import 'package:flutter_test/flutter_test.dart';
import 'package:dark_fast_switcher/dark_fast_switcher.dart';
import 'package:dark_fast_switcher/dark_fast_switcher_state.dart';

void main() {
  testWidgets('Widget changed his state on tap and callback is executed',
      (WidgetTester tester) async {
    int _callbackCounter = 0;
    DarkFastSwitcherState _currentState = DarkFastSwitcherState.on;

    // Create the widget by telling the tester to build it.
    DarkFastSwitcher _switcher = DarkFastSwitcher(
      state: _currentState,
      valueChanged: (state) {
        _currentState = state;
        _callbackCounter++;
      },
    );

    // Build the widget.
    await tester.pumpWidget(_switcher);

    // Tap the switcher while current state is 'ON'.
    await tester.tap(find.byType(DarkFastSwitcher));

    // Rebuild the widget after the state has changed.
    await tester.pump();

    // Expect to state changed to 'OFF' and callback executed
    expect(_currentState, DarkFastSwitcherState.off);
    expect(_callbackCounter, 1);

    // Tap the switcher while current state is 'OFF'.
    await tester.tap(find.byType(DarkFastSwitcher));

    // Rebuild the widget after the state has changed.
    await tester.pump();

    // Expect to state changed to 'ON' and callback executed
    expect(_currentState, DarkFastSwitcherState.on);
    expect(_callbackCounter, 2);
  });
}
