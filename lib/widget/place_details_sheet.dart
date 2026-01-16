import 'package:flutter/material.dart';

void showPlaceDetailsSheet(
  BuildContext context,
  String name,
  String address,
  double lat,
  double lng,
) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) => Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(address),
          const SizedBox(height: 8),
          Text('Coordenadas: ${lat.toStringAsFixed(5)}, ${lng.toStringAsFixed(5)}'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: Navigator.of(ctx).pop,
              child: const Text('Fechar'),
            ),
          ),
        ],
      ),
    ),
  );
}