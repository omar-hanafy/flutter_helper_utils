import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

extension FHUStringExtensions on String {
  /// flutter and dart => Flutter and dart
  String get capitalizeFirstLetter =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';

  /// flutter and dart => FlutterAndDart
  String get toPascalCase => [
        for (final e in toLowerCase().trim().split(' '))
          e.capitalizeFirstLetter,
      ].join();

  /// flutter and dart => flutterAndDart
  String get toCamelCase {
    if (isEmpty) return '';
    final result = splitMapJoin(
      RegExp(r'[\s\-_.]'),
      onMatch: (m) => '',
      onNonMatch: (n) {
        if (n.isEmpty) return '';
        return n.substring(0, 1).toUpperCase() + n.substring(1).toLowerCase();
      },
    );
    return result[0].toLowerCase() + result.substring(1);
  }

  /// flutter and dart => Flutter and Dart
  String get toTitleCase {
    if (isEmpty) return '';
    return splitMapJoin(
      RegExp(r'[\s\-_.]'), // Changed regular expression
      onMatch: (m) => ' ',
      onNonMatch: (n) {
        if (n.isEmpty || shouldIgnoreCapitalization) return n;
        return n.substring(0, 1).toUpperCase() + n.substring(1).toLowerCase();
      },
    );
  }

  /// similar to [toTitleCase] but [toTitle] ignores the `-` and `_`.
  /// e.g. flutter-and-dart Flutter-And-Dart.
  /// Useful in some cases when naming events, products etc
  /// and want these characters to be shown.
  String get toTitle {
    if (isEmpty) return '';
    return splitMapJoin(
      RegExp(r'(\s|-|_|\b)'),
      onMatch: (m) => m[0]!,
      onNonMatch: (n) {
        if (n.isEmpty || shouldIgnoreCapitalization) return n;
        return n.substring(0, 1).toUpperCase() + n.substring(1).toLowerCase();
      },
    );
  }

  /// Determines if capitalization should be ignored for this string.
  ///
  /// Returns true in the following cases:
  ///   * The string starts with a number.
  ///   * The string (converted to lowercase) is a common word
  ///     typically found in lowercase within titles (e.g., "a", "the", "and").
  bool get shouldIgnoreCapitalization =>
      startsWithNumber || _titleCaseExceptions.contains(toLowerCase());

  /// Removes consecutive empty lines, replacing them with single newlines.
  String get removeEmptyLines =>
      replaceAll(RegExp(r'(?:[\t ]*(?:\r?\n|\r))+'), '\n');

  /// Converts the string into a single line by replacing all newline characters with spaces.
  String get toOneLine => replaceAll('\n', ' ');

  /// Removes all whitespace characters (spaces) from the string.
  String get removeWhiteSpaces => replaceAll(' ', '');

  /// Removes all whitespace characters and collapses the string into a single line.
  /// This is a combination of 'removeWhiteSpaces' and 'toOneLine'.
  String get clean => removeWhiteSpaces.toOneLine;
}

extension FHUNullSafeStringExtensions on String? {
  bool get isEmptyOrNull =>
      this == null ||
      this!.isEmpty ||
      this!.removeEmptyLines.toOneLine.removeWhiteSpaces.isEmpty;

  bool get isNotEmptyOrNull => !isEmptyOrNull;

  /// Checks if the string is a palindrome.
  bool get isPalindrome {
    if (isEmptyOrNull) return false;

    final cleanString = this!
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '')
        .replaceAll(RegExp('[^0-9a-zA-Z]+'), '');

    // Iterate only up to half the length of the string
    for (var i = 0; i < cleanString.length ~/ 2; i++) {
      if (cleanString[i] != cleanString[cleanString.length - i - 1]) {
        return false;
      }
    }
    return true;
  }

  /// Checks if the string contains only letters, numbers.
  bool get isAlphanumeric => hasMatch(r'^[a-zA-Z0-9]+$');

  /// Checks if the string contains any characters that are not letters, numbers, or spaces (i.e., special characters).
  bool get hasSpecialChars => hasMatch('[^a-zA-Z0-9 ]');

  /// Checks if the string does NOT contains any characters that are not letters, numbers, or spaces (i.e., special characters).
  bool get hasNoSpecialChars => !hasSpecialChars;

  /// Checks if the string starts with a number (digit).
  bool get startsWithNumber => hasMatch(r'^\d');

  /// check if String contains any digits.
  /// f1rstDate -> true
  /// firstDate -> false
  bool get containsDigits => hasMatch(r'\d');

  /// Checks if string is a valid username.
  bool get isValidUsername =>
      hasMatch(r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$');

  /// Checks if string is Currency.
  bool get isValidCurrency => hasMatch(
        r'^(S?\$|\₩|Rp|\¥|\€|\₹|\₽|fr|R\$|R)?[ ]?[-]?([0-9]{1,3}[,.]([0-9]{3}[,.])*[0-9]{3}|[0-9]+)([,.][0-9]{1,2})?( ?(USD?|AUD|NZD|CAD|CHF|GBP|CNY|EUR|JPY|IDR|MXN|NOK|KRW|TRY|INR|RUB|BRL|ZAR|SGD|MYR))?$',
      );

  /// Checks if string is phone number.
  bool get isValidPhoneNumber {
    if (isEmptyOrNull || this!.length > 16 || this!.length < 9) return false;
    return hasMatch(
        r'(\+\d{1,3}\s?)?((\(\d{3}\)\s?)|(\d{3})(\s|-?))(\d{3}(\s|-?))(\d{4})(\s?(([E|e]xt[:|.|]?)|x|X)(\s?\d+))?');
  }

  /// Checks if string is email.
  bool get isValidEmail => hasMatch(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      );

  /// Checks if string is an html file/url.
  bool get isValidHTML => (this ?? ' ').toLowerCase().endsWith('.html');

  /// check if the string is an IP Version 4
  /// Accept:
  ///   127.0.0.1
  ///   192.168.1.1
  ///   192.168.1.255
  ///   255.255.255.255
  ///   0.0.0.0
  ///   1.1.1.01 -> This is an invalid IP address!
  /// Reject:
  ///   30.168.1.255.1
  ///   127.1
  ///   192.168.1.256
  ///   -1.2.3.4
  ///   1.1.1.1.
  ///   3...3
  bool get isValidIp4 => hasMatch(
        r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
      );

  /// Handle all condition for ipv6
  /// Accepts:
  /// FE80::8329
  /// FE80::FFFF:8329
  /// FE80::B3FF:FFFF:8329
  /// FE80::0202:B3FF:FFFF:8329
  /// FE80::0000:0202:B3FF:FFFF:8329
  /// FE80::0000:0000:0202:B3FF:FFFF:8329
  /// FE80:0000:0000:0000:0202:B3FF:FFFF:8329
  ///
  /// Test this RegEx here -> https://regex101.com/r/aL7tV3/1
  bool get isValidIp6 => hasMatch(
        r'/(?<protocol>(?:http|ftp|irc)s?:\/\/)?(?:(?<user>[^:\n\r]+):(?<pass>[^@\n\r]+)@)?(?<host>(?:www\.)?(?:[^:\/\n\r]+)(?::(?<port>\d+))?)\/?(?<request>[^?#\n\r]+)?\??(?<query>[^#\n\r]*)?\#?(?<anchor>[^\n\r]*)?/',
      );

  /// checks if the string is valid URL or not.
  bool get isValidUrl => isEmptyOrNull
      ? isNotEmptyOrNull
      : this!.toLowerCase().removeEmptyLines.removeWhiteSpaces.hasMatch(
          r'''^((?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))+$''',
          caseSensitive: false,
        );

  bool hasMatch(String pattern, {bool caseSensitive = true}) => (this != null)
      ? RegExp(pattern, caseSensitive: caseSensitive).hasMatch(this!)
      : this != null;

  /// Checks if string consist only Numbers. (No Whitespace)
  bool get isNumeric => hasMatch(r'^\d+$');

  /// Checks if string consist only Alphabet. (No Whitespace)
  bool get isAlphabet => hasMatch(r'^[a-zA-Z]+$');

  /// Checks if string contains at least one Capital Letter
  bool get hasCapitalLetter => hasMatch('[A-Z]');

  /// Checks if string is boolean.
  bool get isBool => this == 'true' || this == 'false';

  String? get removeWhiteSpaces => this?.replaceAll(' ', '');

  // String get withoutWhiteSpaces => isEmptyOrNull ? '' : this!.replaceAll(RegExp(r'\s+\b|\b\s'), '');
  Size get textSize {
    final textPainter = TextPainter(
      text: TextSpan(text: this),
      maxLines: 1,
    )..layout();
    return textPainter.size;
  }

  /// This method allows for dynamic text formatting, useful in scenarios where text needs to be displayed
  /// in a constrained space or in a specific visual structure.
  /// Extends the `String` class to include a `wrapString` method, allowing customized wrapping of text.
  ///
  /// This method provides flexible text wrapping based on the specified word count, wrapping behavior,
  /// and custom delimiter for wrapping. It handles strings with leading, trailing, or multiple consecutive spaces gracefully.
  ///
  /// Parameters:
  /// - `wrapCount`: An integer specifying after how many words the text should be wrapped.
  ///   If less than or equal to 0, it defaults to 1. This parameter determines the granularity of wrapping.
  /// - `wrapEach`: A boolean that controls the wrapping behavior. If true, the method wraps the text after every
  ///   `wrapCount` words throughout the entire string. If false, the text is wrapped just once after the first
  ///   `wrapCount` words, and the rest of the text remains unwrapped.
  /// - `delimiter`: A string that specifies what character(s) to use for wrapping. Defaults to '\n'.
  ///
  /// Usage:
  /// - To wrap each word individually, set `wrapEach` to true with `wrapCount` as 1.
  ///   Example: `"This is a test".wrapString(wrapCount: 1, wrapEach: true)` results in:
  ///   ```
  ///   This
  ///   is
  ///   a
  ///   test
  ///   ```
  ///
  /// - To wrap the text once after a specific number of words, set `wrapEach` to false.
  ///   Example: `"This is a test".wrapString(wrapCount: 2, wrapEach: false)` results in:
  ///   ```
  ///   This is
  ///   a test
  ///   ```
  String wrapString({
    int wordCount = 1,
    bool wrapEach = false,
    String delimiter = '\n',
  }) {
    if (isEmptyOrNull) return '';
    final wrapCount = wordCount <= 0 ? 1 : wordCount;
    // Handling strings with multiple consecutive spaces by reducing them to single spaces.
    final words = this!.trim().replaceAll(RegExp(' +'), ' ').split(' ');
    if (words.isEmpty) return '';
    final buffer = StringBuffer();

    if (wrapEach) {
      for (var i = 0; i < words.length; i++) {
        buffer.write(words[i]);
        if ((i + 1) % wrapCount == 0 && i != words.length - 1) {
          buffer.write(delimiter);
        } else if (i != words.length - 1) {
          buffer.write(' ');
        }
      }
    } else {
      for (var i = 0; i < words.length; i++) {
        buffer.write(words[i]);
        if (i == wrapCount - 1 && words.length > wrapCount) {
          buffer.write(delimiter);
        } else if (i != words.length - 1) {
          buffer.write(' ');
        }
      }
    }

    return buffer.toString();
  }

  /// Compares the current string with another string for equality, ignoring case differences.
  ///
  /// This method performs a case-insensitive comparison between the current string instance and another string.
  /// It returns `true` if the strings are considered equal when case differences are disregarded. This method is null-safe,
  /// meaning it also considers two null values as equal, and a null value is not equal to a non-null value.
  ///
  /// Parameters:
  /// - `other`: The string to compare with the current string. It can be null.
  ///
  /// Returns:
  /// - `true` if the current string and the `other` string are both null, or if they are equal ignoring case differences.
  /// - `false` otherwise, including when one string is null and the other is not.
  ///
  /// Example Usage:
  /// ```dart
  /// var str1 = 'Hello';
  /// var str2 = 'hello';
  /// var str3 = 'world';
  /// var result1 = str1.equalsIgnoreCase(str2); // true
  /// var result2 = str1.equalsIgnoreCase(str3); // false
  /// var result3 = str1.equalsIgnoreCase(null); // false
  /// var result4 = (null as String?).equalsIgnoreCase(null); // true
  /// ```
  ///
  /// This method is useful for comparing strings in a way that is insensitive to whether letters are uppercase or lowercase.
  bool equalsIgnoreCase(String? other) =>
      (this == null && other == null) ||
      (this != null &&
          other != null &&
          this!.toLowerCase() == other.toLowerCase());

  /// Return the string only if the delimiter exists in both ends, otherwise it will return the current string
  String? removeSurrounding(String delimiter) {
    if (this == null) return null;
    final prefix = delimiter;
    final suffix = delimiter;

    if ((this!.length >= prefix.length + suffix.length) &&
        this!.startsWith(prefix) &&
        this!.endsWith(suffix)) {
      return this!.substring(prefix.length, this!.length - suffix.length);
    }
    return this;
  }

  ///  Replace part of string after the first occurrence of given delimiter with the [replacement] string.
  ///  If the string does not contain the delimiter, returns [defaultValue] which defaults to the original string.
  String? replaceAfter(
    String delimiter,
    String replacement, [
    String? defaultValue,
  ]) {
    if (this == null) return null;
    final index = this!.indexOf(delimiter);
    return (index == -1)
        ? defaultValue.isEmptyOrNull
            ? this
            : defaultValue
        : this!.replaceRange(index + 1, this!.length, replacement);
  }

  /// Replace part of string before the first occurrence of given delimiter with the [replacement] string.
  ///  If the string does not contain the delimiter, returns [missingDelimiterValue?] which defaults to the original string.
  String? replaceBefore(
    String delimiter,
    String replacement, [
    String? defaultValue,
  ]) {
    if (this == null) return null;
    final index = this!.indexOf(delimiter);
    return (index == -1)
        ? defaultValue.isEmptyOrNull
            ? this
            : defaultValue
        : this!.replaceRange(0, index, replacement);
  }

  ///Returns `true` if at least one element matches the given [predicate].
  /// the [predicate] should have only one character
  bool anyChar(bool Function(String element) predicate) =>
      isEmptyOrNull ? isEmptyOrNull : this!.split('').any((s) => predicate(s));

  /// Returns the string if it is not `null`, or the empty string otherwise
  String get orEmpty => this ?? '';

  /// if the string is empty perform an action
  Future<T>? ifEmpty<T>(Future<T> Function() action) =>
      isEmptyOrNull ? action() : null;

  String get lastIndex {
    if (isEmptyOrNull) return '';
    return this![this!.length - 1];
  }

  /// Parses the string as an num or returns `null` if it is not a number.
  num? get tryToNum => this == null ? null : num.tryParse(this!);

  /// Parses the string as an double or returns `null` if it is not a number.
  double? get tryToDouble =>
      this == null ? null : num.tryParse(this!).tryToDouble;

  /// Parses the string as an int or returns `null` if it is not a number.
  int? get tryToInt => this == null ? null : num.tryParse(this!).tryToInt;

  /// Parses the string as an num or returns `null` if it is not a number.
  num get toNum => num.parse(this!);

  /// Parses the string as an double or returns `null` if it is not a number.
  double get toDouble => num.parse(this!).toDouble();

  /// Parses the string as an int or returns `null` if it is not a number.
  int get toInt => num.parse(this!).toInt();

  /// Returns true if s is neither null, empty nor is solely made of whitespace characters.
  bool get isNotBlank => this != null && this!.trim().isNotEmpty;

  /// Returns a list of chars from a String
  List<String> toCharArray() => isNotBlank ? this!.split('') : [];

  /// Returns a new string in which a specified string is inserted at a specified index position in this instance.
  String insert(int index, String str) =>
      (List<String>.from(toCharArray())..insert(index, str)).join();

  /// Indicates whether a specified string is `null`, `empty`, or consists only of `white-space` characters.
  bool get isNullOrWhiteSpace {
    final length = (this?.split('') ?? []).where((x) => x == ' ').length;
    return length == (this?.length ?? 0) || isEmptyOrNull;
  }

  /// Shrink a string to be no more than [maxSize] in length, extending from the end.
  /// For example, in a string with 10 charachters, a [maxSize] of 3 would return the last 3 charachters.
  String? limitFromEnd(int maxSize) => (this?.length ?? 0) < maxSize
      ? this
      : this!.substring(this!.length - maxSize);

  /// Shrink a string to be no more than [maxSize] in length, extending from the start.
  /// For example, in a string with 10 charachters, a [maxSize] of 3 would return the first 3 charachters.
  String? limitFromStart(int maxSize) =>
      (this?.length ?? 0) < maxSize ? this : this!.substring(0, maxSize);

  /// Convert this string into boolean.
  ///
  /// Returns `true` if this string is any of these values: `"true"`, `"yes"`, `"1"`, or if the string is a number and greater than 0, `false` if less than 1. This is also case insensitive.
  bool get asBool {
    try {
      final s =
          this?.removeWhiteSpaces.removeEmptyLines.toLowerCase() ?? 'false';
      return s == 'true' ||
          s == 'yes' ||
          s == '1' ||
          s == 'ok' ||
          s.tryToNum.asBool;
    } catch (_) {
      return false;
    }
  }

  /// Decodes the JSON string into a dynamic data structure.
  ///
  /// This getter attempts to decode the current string as JSON. It's designed to be safe against
  /// null or empty strings, returning null in such cases to avoid exceptions. For non-empty, valid
  /// JSON strings, it returns the decode dynamic data structure, which could be a list, map, or any
  /// other type that is a valid JSON structure.
  ///
  /// Returns:
  /// - A dynamic data structure representing the decode JSON if the string is non-empty and valid.
  /// - `null` if the string is null or empty, or if the string is not a valid JSON format.
  ///
  /// Example Usage:
  /// ```dart
  /// var jsonString = '{"name": "John", "age": 30}';
  /// var decoded = jsonString.decode();
  /// print(decoded); // Output: {name: John, age: 30}
  ///
  /// var emptyString = '';
  /// var nullString = null;
  /// print(emptyString.decode()); // Output: null
  /// print(nullString.decode()); // Output: null
  /// ```
  ///
  /// Note:
  /// - This method does not handle parsing errors for invalid JSON formats. It's recommended to ensure
  ///   that the string is a valid JSON before calling this getter or handle the potential `FormatException`
  ///   that could be thrown by `json.decode` when dealing with unknown JSON strings.
  dynamic decode({Object? Function(Object? key, Object? value)? reviver}) =>
      isEmptyOrNull ? null : json.decode(this!, reviver: reviver);
}

List<String> get _titleCaseExceptions => const <String>[
      'a',
      'abaft',
      'about',
      'above',
      'afore',
      'after',
      'along',
      'amid',
      'among',
      'an',
      'apud',
      'as',
      'aside',
      'at',
      'atop',
      'below',
      'but',
      'by',
      'circa',
      'down',
      'for',
      'from',
      'given',
      'in',
      'into',
      'lest',
      'like',
      'mid',
      'midst',
      'minus',
      'near',
      'next',
      'of',
      'off',
      'on',
      'onto',
      'out',
      'over',
      'pace',
      'past',
      'per',
      'plus',
      'pro',
      'qua',
      'round',
      'sans',
      'save',
      'since',
      'than',
      'thru',
      'till',
      'times',
      'to',
      'under',
      'until',
      'unto',
      'up',
      'upon',
      'via',
      'vice',
      'with',
      'worth',
      'the',
      'and',
      'nor',
      'or',
      'yet',
      'so',
    ];
