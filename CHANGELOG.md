# Changelog

All notable changes to this package will be documented in this file.

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
