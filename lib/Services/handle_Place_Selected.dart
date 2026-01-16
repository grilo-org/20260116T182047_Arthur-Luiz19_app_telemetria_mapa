import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceService {
  static Future<void> moveToPlace(
    GoogleMapController controller,
    String placeId,
  ) async {
    final apiKey = dotenv.env['CHAVE_API_GOOGLE_MAPS'];
    if (apiKey == null || apiKey.isEmpty) return;

    final detailUri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/details/json',
      {'place_id': placeId, 'key': apiKey, 'fields': 'geometry'},
    );

    final detailResponse = await http.get(detailUri);
    if (detailResponse.statusCode != 200) return;

    final detail = json.decode(detailResponse.body)['result'];
    final location = detail['geometry']['location'];
    final lat = location['lat'];
    final lng = location['lng'];

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 16),
      ),
    );
  }
}