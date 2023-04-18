# Flutter Helper Utils

The Flutter Helper Utils is a valuable tool for developers who want to speed up their development process. It offers various extensions and helper methods that can make development more efficient.

## Installation

To use this package, add `flutter_helper_utils` as a dependency in your `pubspec.yaml` file:

```
dependencies:
  flutter:
    sdk: flutter
  flutter_helper_utils: ^1.0.0
```

Then, run `flutter packages get` in your terminal.

## Usage

After installation, import the package in your dart file:

```
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
```

You can now use any of the helper methods or extensions provided by the package. Some examples include:

```
// Example of using the isNullOrEmpty extension on a String
String name = '';
if(name.isNullOrEmpty) {
  print('Name is null or empty');
}

// Example of using the addHours extension on a date
DateTime date = DateTime.now();
DateTime extraTwoHours = date.addHours(2);

// Example of using the ConvertObject helper methods to convert a map to User object.
factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: ConvertObject.toInt(map['user']),
      walletBalance: ConvertObject.tryToDouble(map['walletBalance']),
      posts: ConvertObject.toList<Posts>(map['posts']);
    );
  }
```

## Contributions

Contributions to this package are welcome. If you have any suggestions, issues, or feature requests, please create a pull request on the repository.

## License

`flutter_helper_utils` is available under the [BSD 3-Clause License.](https://opensource.org/license/bsd-3-clause/)

<a href="https://www.buymeacoffee.com/omar.hanafy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
