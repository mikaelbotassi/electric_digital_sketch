/// Base exception used by the package to expose domain-specific failures.
class ElectricDigitalSketchException implements Exception {
  /// Creates an exception with a message and an optional stack trace.
  ElectricDigitalSketchException(this.message, [this.stackTrace]);

  /// Error message intended for logs or user-facing adaptation.
  final String message;

  /// Stack trace associated with the failure, when available.
  final StackTrace? stackTrace;

  @override
  String toString() {
    if (stackTrace == null) {
      return '$message\n$stackTrace';
    }
    return message;
  }
}
