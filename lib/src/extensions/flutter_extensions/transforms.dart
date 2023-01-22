import 'package:flutter/material.dart';

import './transforms/click_translate.dart';

extension TransformExtensions on Widget {
  Widget get pushEffectOnClick => TranslateOnClick(child: this);
}
