import 'package:flutter/material.dart';

extension IconExtensions<T extends Icon> on T {
  Icon copyWith({
    Color? color,
    double? size,
    String? semanticLabel,
    TextDirection? textDirection,
  }) {
    return Icon(
      icon,
      color: color ?? this.color,
      size: size ?? this.size,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      textDirection: textDirection ?? this.textDirection,
    );
  }

  T iconSize(double size) => copyWith(size: size) as T;

  T iconColor(Color color) => copyWith(color: color) as T;
}
