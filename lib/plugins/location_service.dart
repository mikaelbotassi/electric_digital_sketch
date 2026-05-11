import 'package:electric_shapes/electric_shapes.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {

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

  static Future<LatLong?> getCurrentPosition() async {
    final granted = await ensurePermission();

    if(!granted) return null;

    final lastKnown = await Geolocator.getLastKnownPosition();

    try {
      final current = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      return LatLong(current.latitude, current.longitude);
    } on Exception catch (_) {
      if(lastKnown == null) return null;
      return LatLong(lastKnown.latitude, lastKnown.longitude);
    }
  }
}
