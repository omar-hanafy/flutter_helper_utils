import 'package:flutter/material.dart';

/// convert Sizedbox height/width to percents.
extension SizedBoxExt on SizedBox {
  SizedBox toPercents(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (width != null) return SizedBox(width: (width ?? 0 / size.width) * 1000);
    if (height != null) {
      return SizedBox(height: (height ?? 0 / size.height) * 1000);
    }
    return const SizedBox.shrink();
  }
}
