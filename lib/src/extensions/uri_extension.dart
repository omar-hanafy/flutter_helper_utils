import 'package:flutter_helper_utils/flutter_helper_utils.dart';

extension NullSafeURIExtensions on String? {
  Uri? get toUri => this == null ? null : Uri.tryParse(this!.clean);

  Uri? get toPhoneUri => this == null
      ? null
      : Uri.parse(this!.startsWith('tel://') ? this! : 'tel://${this!.clean}');
}

extension URIExtensions on String {
  Uri get toUri => Uri.parse(clean);

  Uri get toPhoneUri =>
      Uri.parse(startsWith('tel://') ? clean : 'tel://$clean');
}

extension UriEx on Uri {
  /// Extracts the domain name from a URL.
  /// Supports URLs with or without 'www' and different TLDs.
  String get domainName {
    // Split the URL by '.'
    var parts = host.split('.');

    // Remove 'www' if it exists
    if (parts.isNotEmpty && parts[0] == 'www') {
      parts = parts.sublist(1);
    }

    // Return the first part as the domain name, or an empty string if not found
    return parts.isNotEmpty ? parts[0] : host;
  }
}
