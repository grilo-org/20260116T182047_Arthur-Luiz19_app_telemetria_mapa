import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widget/place_details_sheet.dart';

class TelemetryPainel extends StatelessWidget {
  final Position? position;
  final Completer<GoogleMapController> controller;
  final void Function(GoogleMapController) onMapCreated;

  const TelemetryPainel({
    super.key,
    required this.position,
    required this.controller,
    required this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    if (position == null) {
      return const Center(child: Text('Aguardando localização...'));
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(position!.latitude, position!.longitude),
        zoom: 17,
      ),
      onMapCreated: (GoogleMapController mapController) {
        if (!controller.isCompleted) {
          controller.complete(mapController);
        }
        onMapCreated(mapController);
      },
      markers: {
        Marker(
          markerId: const MarkerId('me'),
          position: LatLng(position!.latitude, position!.longitude),
          infoWindow: const InfoWindow(title: 'Sua localização'),
          onTap: () => showPlaceDetailsSheet(
            context,
            'Sua localização',
            'Lat: ${position!.latitude}, Lng: ${position!.longitude}',
            position!.latitude,
            position!.longitude,
          ),
        ),
      },
    );
  }
}