### 1.1.9

- **FIX**: Fixed a bug with `isZero` bool in numbers extensions.
- **UPDATE**: `asBool` support null safety on numbers extensions.
- **UPDATE**: Updated `ParsingException` implementation.

### 1.1.8

- **NEW**: Added `isPositiveOrNull`, `isZeroOrNull`, and `isNegativeOrNull` to all numbers extensions.
- **UPDATE**: on String extension, `isEmptyOrNull` now returns true if string has only empty lines.

### 1.1.7

- **NEW**:  Added `toDateTime` and `tryToDateTime` in `ConvertObject` class.

### 1.1.6

- **NEW**:  Added `toMap` and `tryToMap` in `ConvertObject` class, and add `isValidSVG` in String extension.

### 1.1.5

- **NEW**:  Added `toBool` and `tryToBool` in `ConvertObject` class.
- **UPDATE**:  Improved all implementations of static methods in `ConvertObject` class.

### 1.1.4

- **NEW**:  Supported converting timestamp milliseconds to `DateTime` and added `tryToString` in `ConvertObject` class.

### 1.1.3

- **FIX**: Added missing `pushNamedAndRemoveUntil` in the navigation extension.

### 1.1.2

- **UPDATE**: Improved `asBool` implementation in the string extension.

### 1.1.1

- **FIX**: Fixed a bug in `camelCase` conversion algorithm.

### 1.1.0

- **FIX**: Fixed logo does not appear in readme file.

### 1.0.9

- **UPDATE**: Re-organized changelog and updated readme file.

### 1.0.8

- **FIX**: Fixed bug with `isHexColor` in color extension.

### 1.0.7

- **NEW**: Added new color extension to support converting hex string to color and checking if string is a hex color.

### 1.0.6

- **UPDATE**: Supported null safety to ThemeMode and Brightness.

### 1.0.5

- **UPDATE**: Changed `pop` to `popPage` to solve conflicts with `go_router` package extensions.

### 1.0.4

- **UPDATE**: Updated readme file.

### 1.0.3

- **NEW**: Added `capitalizeFirstLetter`, `toPascalCase`, `toTitleCase`, and `toCamelCase` to String extension.

### 1.0.2

- **UPDATE**: Renamed some getters to fix conflicts with the `get` package.

### 1.0.1

- **UPDATE**: Updated readme file.

### 1.0.0

- **INITIAL**: Initial release.
