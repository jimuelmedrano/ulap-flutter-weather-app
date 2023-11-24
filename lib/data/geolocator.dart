import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Future<Position> _getpos() async {
  Position defaultPos = Position(
      longitude: 120.9786117,
      latitude: 14.5826683,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0);

  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Return default position(Manila) if location service is not enabled
    return defaultPos;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Return default position(Manila) if permission is denied
      return defaultPos;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Return default poosition(Manila) if permissions are denied forever, handle appropriately.
    return defaultPos;
  }

  return await Geolocator.getCurrentPosition();
}

Future<List<Placemark>> getAddress() async {
  Position position = await _getpos();
  return placemarkFromCoordinates(position.latitude, position.longitude);
}
