---
title: Getting Started
---

# Getting Started

## 1- Prerequisites

- Ensure you have [Flutter](https://flutter.dev/) installed on your development machine.
- You should have an existing Flutter project where you plan to use Flutter Helper Utils.

## 2- Installation

[![pub package](https://img.shields.io/pub/v/flutter_helper_utils)](https://pub.dev/packages/flutter_helper_utils)

1. Open your Flutter project's `pubspec.yaml` file.

2. Add `flutter_helper_utils` to your project's dependencies:

   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     flutter_helper_utils: ^latest_version
   ```

3. Save the `pubspec.yaml` file and run:

   ```shell
   flutter pub get
   ```

   This command will fetch and add the package to your project.

## 3- Importing the Package

You can now import the package into your Dart files:

```dart
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
```