import 'package:flutter/foundation.dart';

/// A platform-independent class providing information about the operating system,
/// with web compatibility considerations.
abstract class PlatformEnv {
  /// Returns the `TargetPlatform` corresponding to the current operating system.
  static TargetPlatform get targetPlatform => defaultTargetPlatform;

  /// Returns `false` since the current platform is not Linux.
  static bool get isLinux => false;

  /// Returns `false` since the current platform is not macOS.
  static bool get isMacOS => false;

  /// Returns `false` since the current platform is not Windows.
  static bool get isWindows => false;

  /// Returns `false` since the current platform is not Android.
  static bool get isAndroid => false;

  /// Returns `false` since the current platform is not iOS.
  static bool get isIOS => false;

  /// Returns `true` since the current platform is web.
  static bool get isWeb => true;

  /// Returns `false` since the current platform is not Fuchsia.
  static bool get isFuchsia => false;

  /// Returns the string 'web' as the operating system.
  static String get operatingSystem => 'web';

  /// Returns 'N/A' as the operating system version on web platforms.
  static String get operatingSystemVersion => 'N/A';

  /// Returns `0` since the number of processors is not available on web platforms.
  static int get numberOfProcessors => 0;

  /// Returns `/` as the path separator on web platforms.
  static String get pathSeparator => '/';

  /// Returns 'localhost' as the local hostname on web platforms.
  static String get localHostname => 'localhost';

  /// Returns 'N/A' as the version of the current Dart runtime on web platforms.
  static String get version => 'N/A';

  /// Returns 'en' as the default locale name on web platforms.
  static String get localeName => 'en';

  /// Returns an empty map since environment variables are not available on web platforms.
  static Map<String, String> get environment => {};

  /// Returns 'N/A' as the executable path on web platforms.
  static String get executable => 'N/A';

  /// Returns 'N/A' as the resolved executable path on web platforms.
  static String get resolvedExecutable => 'N/A';

  /// Returns an empty URI as the script URI on web platforms.
  static Uri get script => Uri();

  /// Returns an empty list since no executable arguments are available on web platforms.
  static List<String> get executableArguments => [];

  /// Returns `null` since the `--packages` flag is not applicable on web platforms.
  static String? get packageConfig => null;

  /// Returns `'\n'` as the system's default line terminator on web platforms.
  static String get lineTerminator => '\n';

  static Map<String, String> report() => {
        'targetPlatform': targetPlatform.name,
        'operatingSystem': operatingSystem,
        'operatingSystemVersion': operatingSystemVersion,
        'numberOfProcessors': '$numberOfProcessors',
        'pathSeparator': pathSeparator,
        'localHostname': localHostname,
        'version': version,
        'localeName': localeName,
        ...environment,
        'executable': executable,
        'resolvedExecutable': resolvedExecutable,
        'script': '$script',
        'executableArguments': '$executableArguments',
        'packageConfig': '$packageConfig',
        'lineTerminator': lineTerminator,
      };
}
