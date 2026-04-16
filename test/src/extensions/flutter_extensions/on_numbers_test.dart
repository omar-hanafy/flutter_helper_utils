import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FHUNumExtensions', () {
    test('edgeInsetsStart creates directional start padding', () {
      final geometry = 12.edgeInsetsStart;

      expect(geometry, const EdgeInsetsDirectional.only(start: 12));
    });

    test('edgeInsetsEnd creates directional end padding', () {
      final geometry = 18.edgeInsetsEnd;

      expect(geometry, const EdgeInsetsDirectional.only(end: 18));
    });
  });
}
