## Duration Extension in `flutter_helper_utils`

Enhance your `Duration` objects with these utility methods provided by `DurationExt`.

### `delayed`

Utility to delay some code execution.

```dart
await 3.seconds.delay(() {
  // Your code here
});
```

### `fromNow`

Adds the Duration to the current `DateTime` and gives a future time.

```dart
final futureTime = 5.minutes.fromNow;
```

### `ago`

Subtracts the Duration from the current `DateTime` and gives a past time.

```dart
final pastTime = 5.minutes.ago;
```