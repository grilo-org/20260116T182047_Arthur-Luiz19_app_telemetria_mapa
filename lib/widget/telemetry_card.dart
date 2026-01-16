import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../providers/telemetry_provider.dart';

class TelemetryCard extends StatelessWidget {
  final VoidCallback onLocationPress;

  const TelemetryCard({
    super.key,
    required this.onLocationPress,
  });

  @override
  Widget build(BuildContext context) {
    final telemetry = Provider.of<TelemetryProvider>(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton.small(
                heroTag: 'btnLocation',
                backgroundColor: Colors.white,
                onPressed: onLocationPress,
                child: const Icon(Icons.my_location, color: Colors.blueAccent),
              ),
            ),
            Text(
              'Velocidade: ${telemetry.speed.toStringAsFixed(1)} km/h',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Aceleração: ${telemetry.acceleration.toStringAsFixed(2)} m/s²',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Direção: ${telemetry.direction}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              telemetry.lastUpdateString,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
