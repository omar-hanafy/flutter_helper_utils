---
title: Getting Started
---

# Getting Started

## 1- Prerequisites

- Install [Flutter](https://flutter.dev/) 3.47.7 or newer with Dart 3.13.5 or newer.
- You should have an existing Flutter project where you plan to use Flutter Helper Utils.

## 2- Installation

[![pub package](https://img.shields.io/pub/v/flutter_helper_utils)](https://pub.dev/packages/flutter_helper_utils)

1. Open your Flutter project's `pubspec.yaml` file.

2. Add `flutter_helper_utils` to your project's dependencies:

   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     flutter_helper_utils: ^10.0.0
     material_ui: ^1.6.0
   ```

3. Save the `pubspec.yaml` file and run:

   ```shell
   flutter pub get
   ```

   This command will fetch and add the package to your project.

## 3- Importing the Package

You can now import the package into your Dart files:

```dart
import 'package:material_ui/material_ui.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
```

Use `material_ui.MaterialApp`, theme types, Scaffold, snackbars, and carousel
controllers with FHU's Material helpers. FHU does not re-export Material types.
SDK Material types with the same names are distinct. For upgrades, read the
[v10 migration guide](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/migration_guides.md#version-1000),
including the limits of the temporary legacy compatibility bridge.
