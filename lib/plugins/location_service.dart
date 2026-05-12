import 'package:electric_shapes/electric_shapes.dart';
import 'package:geolocator/geolocator.dart';

/// Helper for requesting location permission and reading the current
/// coordinates as [LatLong].
class LocationService {
  /// Ensures that location services are enabled and permission was granted.
  ///
  /// Returns `true` only when the application can request the current device
  /// location.
  static Future<bool> ensurePermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  /// Returns the current coordinates when permission is granted.
  ///
  /// The method falls back to the last known position when the live request
  /// fails.
  static Future<LatLong?> getCurrentPosition() async {
    final granted = await ensurePermission();

    if (!granted) return null;

    final lastKnown = await Geolocator.getLastKnownPosition();

    try {
      final current = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      return LatLong(current.latitude, current.longitude);
    } on Exception catch (_) {
      if (lastKnown == null) return null;
      return LatLong(lastKnown.latitude, lastKnown.longitude);
    }
  }
}
