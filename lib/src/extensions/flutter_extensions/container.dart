import 'package:flutter/material.dart';

extension ContainerExtensions on Container {
  /// Add round corners to a Container
  ///  if the Container already has a color use [backgroundColor] instead and remove the
  ///  [Color] from the Container it self
  // ignore: use_decorated_box
  Container withRoundCorners({required Color backgroundColor}) => Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: this,
      );

  /// A shadow cast by a box
  ///
  /// [shadowColor]
  Container withShadow(
          {Color shadowColor = Colors.grey,
          double blurRadius = 20.0,
          double spreadRadius = 1.0,
          Offset offset = const Offset(10, 10)}) =>
      // ignore: use_decorated_box
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: shadowColor,
                blurRadius: blurRadius,
                spreadRadius: spreadRadius,
                offset: offset),
          ],
        ),
        child: this,
      );
}
