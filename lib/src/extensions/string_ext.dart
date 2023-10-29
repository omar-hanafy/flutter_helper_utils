import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

extension StringExtensions on String {
  /// flutter and dart => Flutter and dart
  String get capitalizeFirstLetter =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';

  /// flutter and dart => FlutterAndDart
  String get toPascalCase => [
        for (final e in toLowerCase().trim().split(' ')) e.capitalizeFirstLetter
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
  /// Useful in some cases when naming events,
  /// products etc and want these characters to be shown.
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

  bool get shouldIgnoreCapitalization =>
      startsWithNumber || _titleCaseExceptions.contains(toLowerCase());

  String get removeEmptyLines =>
      replaceAll(RegExp(r'(?:[\t ]*(?:\r?\n|\r))+'), '\n');

  String get toOneLine => replaceAll('\n', ' ');

  String get removeWhiteSpaces => replaceAll(' ', '');

  String get clean => removeWhiteSpaces.toOneLine;
}

extension NullSafeStringExtensions on String? {
  bool get isEmptyOrNull =>
      this == null ||
      this!.removeEmptyLines.toOneLine.removeWhiteSpaces.isEmpty;

  bool get isNotEmptyOrNull => !isEmptyOrNull;

  /// Checks if string is Palindrom.
  bool get isPalindrom {
    if (isEmptyOrNull) {
      return false;
    } else {
      final cleanString = this!
          .toLowerCase()
          .replaceAll(RegExp(r'\s+'), '')
          .replaceAll(RegExp('[^0-9a-zA-Z]+'), '');
      for (var i = 0; i < cleanString.length; i++) {
        if (cleanString[i] != cleanString[cleanString.length - i - 1]) {
          return false;
        }
      }
      return true;
    }
  }

  bool get isAlphanumeric => hasMatch(r'^[a-zA-Z0-9 ]+$');

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
      r'^(S?\$|\₩|Rp|\¥|\€|\₹|\₽|fr|R\$|R)?[ ]?[-]?([0-9]{1,3}[,.]([0-9]{3}[,.])*[0-9]{3}|[0-9]+)([,.][0-9]{1,2})?( ?(USD?|AUD|NZD|CAD|CHF|GBP|CNY|EUR|JPY|IDR|MXN|NOK|KRW|TRY|INR|RUB|BRL|ZAR|SGD|MYR))?$');

  /// Checks if string is phone number.
  bool get isValidPhoneNumber {
    if (isEmptyOrNull || this!.length > 16 || this!.length < 9) return false;
    return hasMatch(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  /// Checks if string is email.
  bool get isValidEmail => hasMatch(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  /// Checks if string is an html file.
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
      r'/(?<protocol>(?:http|ftp|irc)s?:\/\/)?(?:(?<user>[^:\n\r]+):(?<pass>[^@\n\r]+)@)?(?<host>(?:www\.)?(?:[^:\/\n\r]+)(?::(?<port>\d+))?)\/?(?<request>[^?#\n\r]+)?\??(?<query>[^#\n\r]*)?\#?(?<anchor>[^\n\r]*)?/');

  bool get isValidUrl => isEmptyOrNull
      ? isNotEmptyOrNull
      : this!.toLowerCase().removeEmptyLines.removeWhiteSpaces.hasMatch(
            r'^(http|ftp|https)?(\:\/\/)?[\w-]+(\.[\w-]+)+([\w.,@?^!=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])+$',
            caseSensitive: false,
          );

  /// Checks if string is an video file.
  bool get isValidVideo {
    final ext = (this ?? ' ').toLowerCase();
    return ext.endsWith('.mp4') ||
        ext.endsWith('.avi') ||
        ext.endsWith('.wmv') ||
        ext.endsWith('.rmvb') ||
        ext.endsWith('.mpg') ||
        ext.endsWith('.mpeg') ||
        ext.endsWith('.3gp');
  }

  /// Checks if string is an audio file.
  bool get isValidAudio {
    final ext = (this ?? ' ').toLowerCase();
    return ext.endsWith('.mp3') ||
        ext.endsWith('.wav') ||
        ext.endsWith('.wma') ||
        ext.endsWith('.amr') ||
        ext.endsWith('.ogg');
  }

  /// Checks if string is an image file.
  bool get isValidImage {
    final ext = (this ?? ' ').toLowerCase();
    return ext.endsWith('.jpg') ||
        ext.endsWith('.jpeg') ||
        ext.endsWith('.png') ||
        ext.endsWith('.gif') ||
        ext.endsWith('.bmp');
  }

  /// Checks if string is an svg file.
  bool get isValidSVG => (this ?? ' ').split('.').last.toLowerCase() == 'svg';

  bool hasMatch(String pattern, {bool caseSensitive = true}) => (this != null)
      ? RegExp(pattern, caseSensitive: caseSensitive).hasMatch(this!)
      : this != null;

  // Check if the string has any number in it, not accepting double, so don't
  // use "."
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

  // Will add new line if the sentence is bigger the 2 words.
  /// [afterWords] will add new line after the selected word
  /// Example
  /// 'Hi, my name is'.wrapString(2)
  ///
  /// will print:
  /// Hi, my
  /// name is
  String wrapString(int afterWords) {
    final wordsArr = this?.split(' ') ?? [];
    if (wordsArr.length > 2) {
      final middle = (this?.indexOf(wordsArr[afterWords]) ?? 0) - 1;
      final prefix = this?.substring(0, middle);
      final postfix = this?.substring(middle + 1);
      return '$prefix\n$postfix';
    }
    return this ?? '';
  }

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
  String? replaceAfter(String delimiter, String replacement,
      [String? defaultValue]) {
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
  String? replaceBefore(String delimiter, String replacement,
      [String? defaultValue]) {
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

// if the string is empty perform an action
  Future<T>? ifEmpty<T>(Future<T> Function() action) =>
      isEmptyOrNull ? action() : null;

  String get lastIndex {
    if (isEmptyOrNull) return '';
    return this![this!.length - 1];
  }

  /// Parses the string as an num or returns `null` if it is not a number.
  num? get tryToNum => this == null ? null : double.tryParse(this!);

  /// Parses the string as an double or returns `null` if it is not a number.
  double? get tryToDouble => this == null ? null : double.tryParse(this!);

  /// Parses the string as an int or returns `null` if it is not a number.
  int? get tryToInt => this == null ? null : int.tryParse(this!);

  /// Parses the string as an num or returns `null` if it is not a number.
  num get toNum => num.parse(this!);

  /// Parses the string as an double or returns `null` if it is not a number.
  double get toDouble => double.parse(this!);

  /// Parses the string as an int or returns `null` if it is not a number.
  int get toInt => int.parse(this!);

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
      return s == 'true' || s == 'yes' || s == '1' || s.tryToNum.asBool;
    } catch (_) {
      return false;
    }
  }
}

const _titleCaseExceptions = <String>[
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
  'so'
];
