import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService {
  static Future<void> goToCurrentLocation(
    GoogleMapController controller,
    Position? pos,
    double bearing,
  ) async {
    if (pos == null) return;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(pos.latitude, pos.longitude),
          zoom: 17,
          bearing: bearing,
        ),
      ),
    );
  }
}
