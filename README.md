# electric_digital_sketch

Offline-first Flutter package for drawing, annotating and exporting electrical
network sketches.

This package provides a ready-to-use editor page built on top of
[`simple_painter`](https://pub.dev/packages/simple_painter), with workflows
focused on electrical design and field sketching.

## Features

- Freehand drawing and erase tools
- Selection, layer management, undo and redo
- Electrical network line mode with specialized line styles
- Geometric shapes and grouped electrical symbols
- Text insertion and editing
- Location and description metadata for custom electrical items
- Result preview with share/export flow
- Confirmation callback that returns the generated image file

## Included editor tools

- `SketchMode.select`
- `SketchMode.brush`
- `SketchMode.erase`
- `SketchMode.changes`
- `SketchMode.text`
- `SketchMode.shapes`
- `SketchMode.layers`
- `SketchMode.redes`

The package also includes grouped electrical symbols such as:

- transformers
- poles
- switches
- grounding items
- surge protection items

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  electric_digital_sketch: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Basic usage

The package exports a single entry-point:

```dart
import 'package:electric_digital_sketch/electric_digital_sketch.dart';
```

Use `ElectricSketchPage` as a full-screen editor:

```dart
import 'dart:io';

import 'package:electric_digital_sketch/electric_digital_sketch.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ElectricSketchPage(
        onConfirm: (File imageFile) async {
          debugPrint('Generated image: ${imageFile.path}');
        },
      ),
    );
  }
}
```

## Export and confirmation flow

When the user opens the result preview:

- the editor renders the current sketch as a PNG file
- the result page shows the generated image
- the user can share/save the file
- if `onConfirm` is provided, the page exposes confirm action and returns the
  generated `File`

Example:

```dart
Widget build(BuildContext context){
  return ElectricSketchPage(
    onConfirm: (file) async {
      // Upload, persist or attach the final PNG file.
    },
  );
}
```

## Platform behavior

- Android and iOS: result export uses the native share sheet
- Desktop platforms: result export uses a native save dialog

## Current public API

Main public types:

- `ElectricSketchPage`
- `ElectricSketchController`
- `SketchMode`
- `LineStyle`
- `ElectricShapeType`
- `LocationService`

## Example project

An example app is included in [`example/`](example).

Run it with:

```bash
flutter run -d <device>
```

## Notes

- The package is designed around an editor page, not a low-level drawing API.
- Internal widgets and controllers may evolve, but `ElectricSketchPage` is the
  intended integration point for consumers.
- Location-related features depend on platform permission configuration in the
  host app.

## License

This project is licensed under the [MIT License](LICENSE).
