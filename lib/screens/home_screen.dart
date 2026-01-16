import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:telemetria/Services/go_to_current_location.dart';
import 'package:telemetria/Services/handle_Place_Selected.dart';
import 'package:telemetria/widget/start_stop_button.dart';
import 'package:telemetria/widget/telemetry_card.dart';
import 'package:telemetria/widget/search_bar.dart';
import 'package:telemetria/widget/telemtry_painel.dart';
import '../providers/telemetry_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<void> _handlePlaceSelected(Map<String, dynamic> prediction) async {
    final placeId = prediction['place_id'] as String;
    final controller = await _controller.future;
    await PlaceService.moveToPlace(controller, placeId);
  }

  Future<void> _goToCurrentLocation(Position? pos, double bearing) async {
    final controller = await _controller.future;
    await MapService.goToCurrentLocation(controller, pos, bearing);
  }

  @override
  Widget build(BuildContext context) {
    final telemetry = Provider.of<TelemetryProvider>(context);
    final pos = telemetry.position;

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Search Telemetria Location'))),
      body: Column(
        children: [
          SearchBarWidget(onPlaceSelected: _handlePlaceSelected),
          Expanded(
            child: TelemetryPainel(
              position: pos,
              controller: _controller,
              onMapCreated: (controller) {
              },
            ),
          ),
          TelemetryCard(
            onLocationPress: () => _goToCurrentLocation(pos, telemetry.heading),
          ),
        ],
      ),
      floatingActionButton: StartStopButton(),
    );
  }
}
