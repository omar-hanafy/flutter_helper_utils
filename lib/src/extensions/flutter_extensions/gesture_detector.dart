import 'package:flutter/material.dart';

import './transforms/click_translate.dart';

extension GestureDetectorExtensions on Widget {
  Widget get onTapAddJumpEffect => TranslateOnClick(child: this);

  Widget onDoubleTap(void Function() function) => GestureDetector(
        onDoubleTap: function,
        child: this,
      );

  Widget onTap(void Function() function) => GestureDetector(
        onTap: function,
        child: this,
      );

  Widget onLongPress(void Function() function) => GestureDetector(
        onLongPress: function,
        child: this,
      );
}
