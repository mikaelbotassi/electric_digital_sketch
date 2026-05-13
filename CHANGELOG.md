# Changelog

All notable changes to this package will be documented in this file.

## 1.0.3

### Added

- Added `initialBackgroundImage` to `ElectricSketchPage` so host apps can open the editor with a predefined background image file.

## 1.0.2

### Chore

- Bumped package version to `1.0.2` in `pubspec.yaml`.
- Refined grammar in `README.md` for the `onConfirm` callback description.

## 1.0.1

### Docs

- Overhauled `README.md` with comprehensive package documentation and usage guides.
- Replaced boilerplate text with a detailed description of the `electric_digital_sketch` package purpose and capabilities.
- Documented core features including electrical network line modes, specialized symbols and offline-first sketching tools.
- Added a list of available `SketchMode` tools and grouped electrical symbols such as transformers, poles and switches.
- Added installation instructions and a basic usage example for the `ElectricSketchPage` entry point.
- Detailed the export and confirmation workflow, including platform-specific behavior for mobile share sheets and desktop save dialogs.
- Defined the primary public API surface and added guidance for using the bundled example project.
- Added sections for platform-specific notes and licensing information.

## 1.0.0

First public release of `electric_digital_sketch`.

### Added

- Main electrical sketch editor page for Flutter apps.
- Drawing support for electrical network lines with specialized line styles.
- Electrical symbol catalog with grouped selection for poles, switches, transformers, grounding and surge protection items.
- Shape, text and layer editing flows built on top of `simple_painter`.
- Location and description metadata inputs for custom electrical symbols.
- Result preview flow with image export, sharing and confirmation callback.
- Package tests covering controller logic, result flow, location helpers and painter extensions.

### Changed

- Refined the toolbar, bottom bar and layer management UI.
- Simplified the internal package structure by removing legacy pages and widgets.
- Migrated electrical shape icons to `ElectricIcons`.
- Improved package documentation and publishing metadata.

### Notes

- This release establishes the initial stable API for embedding the electrical sketch editor in other Flutter projects.
