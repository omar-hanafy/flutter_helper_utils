import 'package:flutter/material.dart';

/// create a [ValueNotifier] of type [Uri], which reacts just like normal [Uri],
/// but with notifier capabilities.
class UriNotifier extends ValueNotifier<Uri> implements Uri {
  UriNotifier(super.initial);

  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } catch (_) {}
  }

  void refresh() {
    final uri = value;
    final newUri = uri.replace();
    value = newUri;
    // force notify if the value setter did not trigger.
    if (uri == newUri) notifyListeners();
  }

  /// similar to value setter but this one force trigger the notifyListeners()
  /// event if newValue == value.
  void update(Uri newValue) {
    value = newValue;
    refresh();
  }

  /// Will notifyListeners after a specific [action] has been made,
  /// and optionally return a result [R] of certain type.
  R _updateOnAction<R>(R Function() action) {
    final result = action();
    refresh();
    return result;
  }

  /// The scheme component of the URI.
  ///
  /// The value is the empty string if there is no scheme component.
  ///
  /// A URI scheme is case insensitive.
  /// The returned scheme is canonicalized to lowercase letters.
  @override
  String get scheme => value.scheme;

  /// The authority component.
  ///
  /// The authority is formatted from the [userInfo], [host] and [port]
  /// parts.
  ///
  /// The value is the empty string if there is no authority component.
  @override
  String get authority => value.authority;

  /// The user info part of the authority component.
  ///
  /// The value is the empty string if there is no user info in the
  /// authority component.
  @override
  String get userInfo => value.userInfo;

  /// The host part of the authority component.
  ///
  /// The value is the empty string if there is no authority component and
  /// hence no host.
  ///
  /// If the host is an IP version 6 address, the surrounding `[` and `]` is
  /// removed.
  ///
  /// The host string is case-insensitive.
  /// The returned host name is canonicalized to lower-case
  /// with upper-case percent-escapes.
  @override
  String get host => value.host;

  /// The port part of the authority component.
  ///
  /// The value is the default port if there is no port number in the authority
  /// component. That's 80 for http, 443 for https, and 0 for everything else.
  @override
  int get port => value.port;

  /// The path component.
  ///
  /// The path is the actual substring of the URI representing the path,
  /// and it is encoded where necessary. To get direct access to the decoded
  /// path, use [pathSegments].
  ///
  /// The path value is the empty string if there is no path component.
  @override
  String get path => value.path;

  /// The query component.
  ///
  /// The value is the actual substring of the URI representing the query part,
  /// and it is encoded where necessary.
  /// To get direct access to the decoded query, use [queryParameters].
  ///
  /// The value is the empty string if there is no query component.
  @override
  String get query => value.query;

  /// The fragment identifier component.
  ///
  /// The value is the empty string if there is no fragment identifier
  /// component.
  @override
  String get fragment => value.fragment;

  /// The URI path split into its segments.
  ///
  /// Each of the segments in the list has been decoded.
  /// If the path is empty, the empty list will
  /// be returned. A leading slash `/` does not affect the segments returned.
  ///
  /// The list is unmodifiable and will throw [UnsupportedError] on any
  /// calls that would mutate it.
  @override
  List<String> get pathSegments => value.pathSegments;

  /// The URI query split into a map according to the rules
  /// specified for FORM post in the [HTML 4.01 specification section
  /// 17.13.4](https://www.w3.org/TR/REC-html40/interact/forms.html#h-17.13.4
  /// "HTML 4.01 section 17.13.4").
  ///
  /// Each key and value in the resulting map has been decoded.
  /// If there is no query, the empty map is returned.
  ///
  /// Keys in the query string that have no value are mapped to the
  /// empty string.
  /// If a key occurs more than once in the query string, it is mapped to
  /// an arbitrary choice of possible value.
  /// The [queryParametersAll] getter can provide a map
  /// that maps keys to all of their values.
  ///
  /// Example:
  /// ```dart import:convert
  /// final uri =
  ///     Uri.parse('https://example.com/api/fetch?limit=10,20,30&max=100').notifier;
  /// print(jsonEncode(uri.queryParameters));
  /// // {"limit":"10,20,30","max":"100"}
  /// ```
  ///
  /// The map is unmodifiable.
  @override
  Map<String, String> get queryParameters => value.queryParameters;

  /// Returns the URI query split into a map according to the rules
  /// specified for FORM post in the [HTML 4.01 specification section
  /// 17.13.4](https://www.w3.org/TR/REC-html40/interact/forms.html#h-17.13.4
  /// "HTML 4.01 section 17.13.4").
  ///
  /// Each key and value in the resulting map has been decoded. If there is no
  /// query, the map is empty.
  ///
  /// Keys are mapped to lists of their values. If a key occurs only once,
  /// its value is a singleton list. If a key occurs with no value, the
  /// empty string is used as the value for that occurrence.
  ///
  /// Example:
  /// ```dart import:convert
  /// final uri =
  ///     Uri.parse('https://example.com/api/fetch?limit=10&limit=20&limit=30&max=100').notifier;
  /// print(jsonEncode(uri.queryParametersAll)); // {"limit":["10","20","30"],"max":["100"]}
  /// ```
  ///
  /// The map and the lists it contains are unmodifiable.
  @override
  Map<String, List<String>> get queryParametersAll => value.queryParametersAll;

  /// Whether the URI is absolute.
  ///
  /// A URI is an absolute URI in the sense of RFC 3986 if it has a scheme
  /// and no fragment.
  @override
  bool get isAbsolute => value.isAbsolute;

  /// Whether the URI has a [scheme] component.
  @override
  bool get hasScheme => value.hasScheme;

  /// Whether the URI has an [authority] component.
  @override
  bool get hasAuthority => value.hasAuthority;

  /// Whether the URI has an explicit port.
  ///
  /// If the port number is the default port number
  /// (zero for unrecognized schemes, with http (80) and https (443) being
  /// recognized),
  /// then the port is made implicit and omitted from the URI.
  @override
  bool get hasPort => value.hasPort;

  /// Whether the URI has a query part.
  @override
  bool get hasQuery => value.hasQuery;

  /// Whether the URI has a fragment part.
  @override
  bool get hasFragment => value.hasFragment;

  /// Whether the URI has an empty path.
  @override
  bool get hasEmptyPath => value.hasEmptyPath;

  /// Whether the URI has an absolute path (starting with '/').
  @override
  bool get hasAbsolutePath => value.hasAbsolutePath;

  /// Returns the origin of the URI in the form scheme://host:port for the
  /// schemes http and https.
  ///
  /// It is an error if the scheme is not "http" or "https", or if the host name
  /// is missing or empty.
  ///
  /// See: https://www.w3.org/TR/2011/WD-html5-20110405/origin-0.html#origin
  @override
  String get origin => value.origin;

  /// Whether the scheme of this [Uri] is [scheme].
  ///
  /// The [scheme] should be the same as the one returned by [Uri.scheme],
  /// but doesn't have to be case-normalized to lower-case characters.
  ///
  /// Example:
  /// ```dart
  /// var uri = Uri.parse('http://example.com').notifier;
  /// print(uri.isScheme('HTTP')); // true
  ///
  /// final uriNoScheme = Uri(host: 'example.com').notifier;
  /// print(uriNoScheme.isScheme('HTTP')); // false
  /// ```
  ///
  /// An empty [scheme] string matches a URI with no scheme
  /// (one where [hasScheme] returns false).
  @override
  bool isScheme(String scheme) => value.isScheme(scheme);

  /// Creates a file path from a file URI.
  ///
  /// The returned path has either Windows or non-Windows
  /// semantics.
  ///
  /// For non-Windows semantics, the slash ("/") is used to separate
  /// path segments.
  ///
  /// For Windows semantics, the backslash ("\\") separator is used to
  /// separate path segments.
  ///
  /// If the URI is absolute, the path starts with a path separator
  /// unless Windows semantics is used and the first path segment is a
  /// drive letter. When Windows semantics is used, a host component in
  /// the uri in interpreted as a file server and a UNC path is
  /// returned.
  ///
  /// The default for whether to use Windows or non-Windows semantics
  /// is determined from the platform Dart is running on. When running in
  /// the standalone VM, this is detected by the VM based on the
  /// operating system. When running in a browser, non-Windows semantics
  /// is always used.
  ///
  /// To override the automatic detection of which semantics to use pass
  /// a value for [windows]. Passing `true` will use Windows
  /// semantics and passing `false` will use non-Windows semantics.
  ///
  /// If the URI ends with a slash (i.e. the last path component is
  /// empty), the returned file path will also end with a slash.
  ///
  /// With Windows semantics, URIs starting with a drive letter cannot
  /// be relative to the current drive on the designated drive. That is,
  /// for the URI `file:///c:abc` calling `toFilePath` will throw as a
  /// path segment cannot contain colon on Windows.
  ///
  /// Examples using non-Windows semantics (resulting of calling
  /// toFilePath in comment):
  /// ```dart
  /// Uri.parse("xxx/yyy");  // xxx/yyy
  /// Uri.parse("xxx/yyy/");  // xxx/yyy/
  /// Uri.parse("file:///xxx/yyy");  // /xxx/yyy
  /// Uri.parse("file:///xxx/yyy/");  // /xxx/yyy/
  /// Uri.parse("file:///C:");  // /C:
  /// Uri.parse("file:///C:a");  // /C:a
  /// ```
  /// Examples using Windows semantics (resulting URI in comment):
  /// ```dart
  /// Uri.parse("xxx/yyy");  // xxx\yyy
  /// Uri.parse("xxx/yyy/");  // xxx\yyy\
  /// Uri.parse("file:///xxx/yyy");  // \xxx\yyy
  /// Uri.parse("file:///xxx/yyy/");  // \xxx\yyy\
  /// Uri.parse("file:///C:/xxx/yyy");  // C:\xxx\yyy
  /// Uri.parse("file:C:xxx/yyy");  // Throws as a path segment
  ///                               // cannot contain colon on Windows.
  /// Uri.parse("file://server/share/file");  // \\server\share\file
  /// ```
  /// If the URI is not a file URI, calling this throws
  /// [UnsupportedError].
  ///
  /// If the URI cannot be converted to a file path, calling this throws
  /// [UnsupportedError].
  @override
  String toFilePath({bool? windows}) => value.toFilePath(windows: windows);

  /// Access the structure of a `data:` URI.
  ///
  /// Returns a [UriData] object for `data:` URIs and `null` for all other
  /// URIs.
  /// The [UriData] object can be used to access the media type and data
  /// of a `data:` URI.
  @override
  UriData? get data => value.data;

  /// Creates a new `Uri` based on this one, but with some parts replaced.
  ///
  /// This method takes the same parameters as the [Uri] constructor,
  /// and they have the same meaning.
  ///
  /// At most one of [path] and [pathSegments] must be provided.
  /// Likewise, at most one of [query] and [queryParameters] must be provided.
  ///
  /// Each part that is not provided will default to the corresponding
  /// value from this `Uri` instead.
  ///
  /// This method is different from [Uri.resolve], which overrides in a
  /// hierarchical manner,
  /// and can instead replace each part of a `Uri` individually.
  ///
  /// Example:
  /// ```dart
  /// final uri1 = Uri.parse(
  ///     'http://dart.dev/guides/libraries/library-tour#utility-classes');
  ///
  /// final uri2 = uri1.replace(
  ///     scheme: 'https',
  ///     path: 'guides/libraries/library-tour',
  ///     fragment: 'uris');
  /// print(uri2); // https://dart.dev/guides/libraries/library-tour#uris
  /// ```
  /// This method acts similarly to using the `Uri` constructor with
  /// some of the arguments taken from this `Uri`. Example:
  /// ``` dart continued
  /// final Uri uri3 = Uri(
  ///     scheme: 'https',
  ///     userInfo: uri1.userInfo,
  ///     host: uri1.host,
  ///     port: uri2.port,
  ///     path: '/guides/language/language-tour',
  ///     query: uri1.query,
  ///     fragment: null);
  /// print(uri3); // https://dart.dev/guides/language/language-tour
  /// ```
  /// Using this method can be seen as shorthand for the `Uri` constructor
  /// call above, but may also be slightly faster because the parts taken
  /// from this `Uri` need not be checked for validity again.
  @override
  Uri replace({
    String? scheme,
    String? userInfo,
    String? host,
    int? port,
    String? path,
    Iterable<String>? pathSegments,
    String? query,
    Map<String, dynamic /*String?|Iterable<String>*/ >? queryParameters,
    String? fragment,
    bool refresh = true,
  }) =>
      _updateOnAction(() => value.replace(
            scheme: scheme,
            userInfo: userInfo,
            host: host,
            port: port,
            path: path,
            pathSegments: pathSegments,
            query: query,
            queryParameters: queryParameters,
            fragment: fragment,
          ));

  /// Creates a `Uri` that differs from this only in not having a fragment.
  ///
  /// If this `Uri` does not have a fragment, it is itself returned.
  ///
  /// Example:
  /// ```dart
  /// final uri =
  ///     Uri.parse('https://example.org:8080/foo/bar#frag').removeFragment();
  /// print(uri); // https://example.org:8080/foo/bar
  /// ```
  @override
  Uri removeFragment() => _updateOnAction(() => value.removeFragment());

  /// Resolve [reference] as an URI relative to `this`.
  ///
  /// First turn [reference] into a URI using [Uri.parse]. Then resolve the
  /// resulting URI relative to `this`.
  ///
  /// Returns the resolved URI.
  ///
  /// See [resolveUri] for details.
  @override
  Uri resolve(String reference) =>
      _updateOnAction(() => value.resolve(reference));

  /// Resolve [reference] as a URI relative to `this`.
  ///
  /// Returns the resolved URI.
  ///
  /// The algorithm "Transform Reference" for resolving a reference is described
  /// in [RFC-3986 Section 5](https://tools.ietf.org/html/rfc3986#section-5
  /// "RFC-1123").
  ///
  /// Updated to handle the case where the base URI is just a relative path -
  /// that is: when it has no scheme and no authority and the path does not
  /// start with a slash.
  /// In that case, the paths are combined without removing leading "..", and
  /// an empty path is not converted to "/".
  @override
  Uri resolveUri(Uri reference) =>
      _updateOnAction(() => value.resolveUri(reference));

  /// Returns a URI where the path has been normalized.
  ///
  /// A normalized path does not contain `.` segments or non-leading `..`
  /// segments.
  /// Only a relative path with no scheme or authority may contain
  /// leading `..` segments;
  /// a path that starts with `/` will also drop any leading `..` segments.
  ///
  /// This uses the same normalization strategy as `Uri().resolve(this)`.
  ///
  /// Does not change any part of the URI except the path.
  ///
  /// The default implementation of `Uri` always normalizes paths, so calling
  /// this function has no effect.
  @override
  Uri normalizePath() => _updateOnAction(() => value.normalizePath());
}
