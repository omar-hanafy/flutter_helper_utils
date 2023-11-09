import 'package:flutter_helper_utils/flutter_helper_utils.dart';

extension NullSafeURIExtensions on String? {
  Uri? get toUri => this == null ? null : Uri.tryParse(this!.clean);

  Uri? get toPhoneUri => this == null
      ? null
      : Uri.parse(this!.startsWith('tel://') ? this! : 'tel://${this!.clean}');
}

extension URIExtensions on String {
  Uri get toUri => Uri.parse(clean);

  Uri get toPhoneUri => Uri.parse(startsWith('tel://') ? this : 'tel://$clean');
}
