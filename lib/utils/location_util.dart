import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Servicios de ubicación deshabilitados');
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Servicios de ubicación deshabilitados');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Servicios de ubicación estan deshabilitados permanentemente');
  }
  return await Geolocator.getCurrentPosition();
}
