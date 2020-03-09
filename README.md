# dark_fast_switcher

**dark_fast_switcher** widget for Flutter project.

![](on_off_switcher.gif)

## Getting Started

For use **dark_fast_switcher** widget in your project:
1. Add dependency in the **pubspec.yaml** file
```dart
    dependencies:
        flutter:
            sdk: flutter
        dark_fast_switcher:
            git:
                url: git@github.com:shekunsky/FLUTTER-on_off_switcher.git
```

2. Import widget in the dart file:
```dart
    import 'package:dark_fast_switcher/dark_fast_switcher.dart';
    import 'package:dark_fast_switcher/dark_fast_switcher_state.dart';
```

3. Make an instance of the widget.

    ```dart
         DarkFastSwitcher(
                state: DarkFastSwitcherState.on,
                valueChanged: (state) {
                  if (state == DarkFastSwitcherState.on) {
                    print('State is ON');
                  } else {
                    print('State is OFF');
                  }
                },
              )
    ```
    
    
    ## License

    Windmill Smart Solutions 2020 ©