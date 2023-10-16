## String Extensions in `flutter_helper_utils`

### `capitalizeFirstLetter`

Capitalizes the first letter of the string.

  ```dart
  String example = "flutter and dart";
  print(example.capitalizeFirstLetter); // Output: "Flutter and dart"
  ```

### `toPascalCase`

Converts the string to Pascal Case.

  ```dart
  String example = "flutter and dart";
  print(example.toPascalCase); // Output: "FlutterAndDart"
  ```

### `toCamelCase`

Converts the string to Camel Case.

  ```dart
  String example = "flutter and dart";
  print(example.toCamelCase); // Output: "flutterAndDart"
  ```

### `toTitleCase`

Converts the string to Title Case.

  ```dart
  String example = "flutter and dart";
  print(example.toTitleCase); // Output: "Flutter And Dart"
  ```

### `toTitle`

Similar to toTitleCase but ignores - and _.

  ```dart
  String example = "flutter-and-dart";
  print(example.toTitle); // Output: "Flutter-And-Dart"
  ```

### `shouldIgnoreCapitalization`

Checks if the string should ignore capitalization.

  ```dart
  String example = "1flutter";
  print(example.shouldIgnoreCapitalization); // Output: true
  ```

### `removeEmptyLines`

Removes empty lines from the string.

  ```dart
  String example = "line1\n\nline2";
  print(example.removeEmptyLines); // Output: "line1\nline2"
  ```

### `toOneLine`

Converts the string to a single line by replacing newlines with spaces.

  ```dart
  String example = "line1\nline2";
  print(example.toOneLine); // Output: "line1 line2"
  ```

### `removeWhiteSpaces`

Removes all white spaces from the string.

  ```dart
  String example = "  flutter  ";
  print(example.removeWhiteSpaces); // Output: "flutter"
  ```

### `isEmptyOrNull`

Checks if the string is empty or null.

  ```dart
  String? example = null;
  print(example.isEmptyOrNull); // Output: true
  ```

### `isNotEmptyOrNull`

Checks if the string is not empty or null.

  ```dart
  String? example = "flutter";
  print(example.isNotEmptyOrNull); // Output: true
  ```

### `isPalindrom`

Checks if the string is a palindrome.

  ```dart
  String? example = "radar";
  print(example.isPalindrom); // Output: true
  ```

### `isAlphanumeric`

Checks if the string is alphanumeric.

  ```dart
  String? example = "abc123";
  print(example.isAlphanumeric); // Output: true
  ```

### `startsWithNumber`

Checks if the string starts with a number.

  ```dart
  String? example = "1flutter";
  print(example.startsWithNumber); // Output: true
  ```

### `containsDigits`

Checks if the string contains any digits.

  ```dart
  String? example = "abc123";
  print(example.containsDigits); // Output: true
  ```

### `isValidUsername`

Checks if the string is a valid username.

  ```dart
  String example = "username_123";
  print(example.isValidUsername); // Output: true
  ```

### `isValidCurrency`

Checks if the string is a valid currency.

  ```dart
  String example = "$100.00 USD";
  print(example.isValidCurrency); // Output: true
  ```

### `isValidPhoneNumber`

Checks if the string is a valid phone number.

  ```dart
  String example = "+1 123-456-7890";
  print(example.isValidPhoneNumber); // Output: true
  ```

### `isValidEmail`

Checks if the string is a valid email address.

  ```dart
  String example = "email@example.com";
  print(example.isValidEmail); // Output: true
  ```

### `isValidHTML`

Checks if the string is an HTML file.

  ```dart
  String example = "index.html";
  print(example.isValidHTML); // Output: true
  ```

### `isValidIp4`

Checks if the string is a valid IPv4 address.

  ```dart
  String example = "192.168.1.1";
  print(example.isValidIp4); // Output: true
  ```

### `isValidIp6`

Checks if the string is a valid IPv6 address.

  ```dart
  String example = "FE80::8329";
  print(example.isValidIp6); // Output: true
  ```

### `isValidUrl`

Checks if the string is a valid URL.

  ```dart
  String example = "https://www.example.com";
  print(example.isValidUrl); // Output: true
  ```

### `isValidVideo`

Checks if the string is a video file.

  ```dart
  String example = "video.mp4";
  print(example.isValidVideo); // Output: true
  ```

### `isValidAudio`

Checks if the string is an audio file.

  ```dart
  String example = "audio.mp3";
  print(example.isValidAudio); // Output: true
  ```

### `isValidImage`

Checks if the string is an image file.

  ```dart
  String example = "image.jpg";
  print(example.isValidImage); // Output: true
  ```

### `isValidSVG`

Checks if the string is an SVG file.

  ```dart
  String example = "image.svg";
  print(example.isValidSVG); // Output: true
  ```

### `hasMatch`

Checks if the string matches a given regular expression pattern.

  ```dart
  String example = "123";
  print(example.hasMatch(r'^\d+$')); // Output: true
  ```

### `isNumeric`

Checks if the string is numeric.

  ```dart
  String example = "123";
  print(example.isNumeric); // Output: true
  ```

### `isAlphabet`

Checks if the string consists only of alphabets.

  ```dart
  String example = "abc";
  print(example.isAlphabet); // Output: true
  ```

### `hasCapitalLetter`

Checks if the string contains at least one capital letter.

  ```dart
  String example = "Abc";
  print(example.hasCapitalLetter); // Output: true
  ```

### `isBool`

Checks if the string is a boolean value.

  ```dart
  String example = "true";
  print(example.isBool); // Output: true
  ```

### `removeWhiteSpaces`

Removes all white spaces from the string.

  ```dart
  String example = "Hello World";
  print(example.removeWhiteSpaces); // Output: HelloWorld
  ```

### `textSize`

Returns the size of the text using TextPainter.

  ```dart
  String example = "Hello";
  print(example.textSize); // Output: Size(width, height)
  ```

### `wrapString`

Adds a new line to the string after a specified number of words.

  ```dart
  String example = "Hi, my name is";
  print(example.wrapString(2)); // Output: "Hi, my\nname is"
  ```

### `equalsIgnoreCase`

Compares two strings for equality, ignoring case.

  ```dart
  String example = "Hello";
  print(example.equalsIgnoreCase("hello")); // Output: true
  ```

### `removeSurrounding`

Removes a specified delimiter from both ends of the string, if present.

  ```dart
  String example = "[Hello]";
  print(example.removeSurrounding("[").removeSurrounding("]")); // Output: Hello
  ```

### `replaceAfter`

Replaces part of the string after the first occurrence of a given delimiter.

  ```dart
  String example = "Hello, World";
  print(example.replaceAfter(",", " everyone")); // Output: Hello, everyone
  ```

### `replaceBefore`

Replaces part of the string before the first occurrence of a given delimiter.

  ```dart
  String example = "Hello, World";
  print(example.replaceBefore(",", "Hi")); // Output: Hi, World
  ```

### `anyChar`

Returns true if any character in the string matches a given predicate function.

  ```dart
  String example = "abc";
  print(example.anyChar((char) => char == 'a')); // Output: true
  ```

### `orEmpty`

Returns the string if it is not null, or an empty string otherwise.

  ```dart
  String? example = null;
  print(example.orEmpty); // Output: ""
  ```

### `ifEmpty`

Executes a given action if the string is empty.

  ```dart
  String example = "";
  example.ifEmpty(() => print("String is empty")); // Output: String is empty
  ```

### `lastIndex`

Returns the last character in the string.

  ```dart
  String example = "abc";
  print(example.lastIndex); // Output: "c"
  ```

### `tryToNum`, `tryToDouble`, `tryToInt`, `toNum`, `toDouble`, `toInt`

Various methods for parsing the string into numbers.

  ```dart
  String example = "123";
  print(example.tryToNum); // Output: 123
  ```

### `isNotBlank`

Checks if the string is neither null, empty, nor made solely of whitespace characters.

  ```dart
  String example = "  ";
  print(example.isNotBlank); // Output: false
  ```

### `toCharArray`

Converts the string to a list of characters.

  ```dart
  String example = "abc";
  print(example.toCharArray()); // Output: ["a", "b", "c"]
  ```

### `insert`

Insert a given string at a specified index.

  ```dart
  String example = "abc";
  print(example.insert(1, "d")); // Output: "adbc"
  ```

### `isNullOrWhiteSpace`

Checks if the string is null, empty, or made solely of whitespace characters.

  ```dart
  String example = "  ";
  print(example.isNullOrWhiteSpace); // Output: true
  ```

### `limitFromEnd`, `limitFromStart`

Limits the string to a specified length from either the start or the end.

  ```dart
  String example = "abcdefgh";
  print(example.limitFromEnd(3)); // Output: "fgh"
  ```

### `asBool`

Converts the string to a boolean value based on certain conditions.

  ```dart
  String example = "true";
  print(example.asBool); // Output: true
  ```

