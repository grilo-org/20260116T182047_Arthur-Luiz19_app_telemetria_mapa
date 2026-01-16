import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/telemetry_provider.dart';

class StartStopButton extends StatelessWidget {
  const StartStopButton({super.key});

  @override
  Widget build(BuildContext context) {
    final telemetry = Provider.of<TelemetryProvider>(context);
    return FloatingActionButton(
      backgroundColor: telemetry.isCollecting ? Colors.red : Colors.green,
      onPressed: telemetry.isCollecting ? telemetry.stop : telemetry.start,
      child: Icon(
        telemetry.isCollecting ? Icons.stop : Icons.play_arrow,
        size: 30,
      ),
    );
  }
}