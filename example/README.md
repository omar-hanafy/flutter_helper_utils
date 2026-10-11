# flutter_helper_utils example

Interactive showcase for Flutter 3.47.7, Dart 3.13.5, and the official
`material_ui` package. The app keeps its original `com.example.example` identity.

```sh
flutter pub get
flutter run -d macos
```

The native scaffolds follow the installed Flutter 3.47.7 templates: Android uses
Gradle 9.3.1, AGP 9.1.0, Kotlin 2.4.0, and Java 17; iOS targets iOS 15 and uses
`FlutterSceneDelegate`; macOS targets macOS 12. CocoaPods remains the Apple
plugin integration path. Linux uses the current `runner/` layout and CMake 3.13,
with its window shown after the first rendered frame. The Windows scaffold
already matches these SDK templates. The web host uses `flutter_bootstrap.js`.

## Verification

```sh
flutter analyze
flutter test test/showcase_test.dart
flutter test integration_test/showcase_test.dart -d macos
flutter build web --release
flutter build apk --debug
(cd android && ./gradlew :app:lintDebug)
flutter build ios --simulator --no-codesign
```

Six widget tests cover the showcase and the utility harnesses. The complete
showcase journey runs at the default size and at 320 x 568, 1024 x 768, and
1440 x 900 with 1.5x text. Of four native integration tests, the first two start
`main()` and repeat the journey in the actual window and in a 320 x 568
constrained rendering surface. The second test controls Flutter constraints;
it does not change the operating system's physical window size. The additional
multi-tap harness verifies immediate repeated sequences, 400ms gaps under a
500ms duration, timeout reset at 150ms under a 100ms duration, scroll gesture
cancellation, and safe disposal while a reset timer is pending. Repeated tap
sequences use 50ms frame gaps to satisfy the serial recognizer's retained
40ms minimum inter-tap interval. The pagination harness verifies that a nested
horizontal scroller cannot load an outer page, and that one pending request
survives parent rebuilds until completion enables the next request.

The journey verifies:

- Official Material theme types and dark/light/system changes through the
  package's context/theme extensions.
- Two triple-tap sequences, their hidden state, and snackbar messages.
- All five typed sliver entries and their detail routes. A guarded back request
  stays on the route and shows feedback; force back exits; ordinary back exits
  routes that allow it.
- Parsed palette output and the native platform report.
- Text entry, focus dismissal, clearing the field, and snackbar feedback.
- Middle, bottom, and top scroll helpers and their final scroll positions.
- Nested-scroll pagination isolation, pending-request exclusion across parent
  rebuilds, and safe completion after disposal.
- No layout exceptions throughout the journey, including narrow screens and
  larger text. Detail pages scroll so their back actions remain reachable.

The demo has no network requests, authentication, persisted state, or counter
flow, so those categories do not have test fixtures here. Native macOS execution
proves the shared Dart journey and macOS integration; Android and iOS builds
prove compilation only until their respective device suites run.
