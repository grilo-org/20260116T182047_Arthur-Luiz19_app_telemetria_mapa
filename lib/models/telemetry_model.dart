import 'package:geolocator/geolocator.dart';

class TelemetryData {
  final Position? position;
  final double speed;
  final double accelX, accelY, accelZ;
  final double heading;
  final DateTime? lastUpdate;
  final bool isCollecting;
  final String address;

  TelemetryData({
    this.position,
    this.speed = 0,
    this.accelX = 0,
    this.accelY = 0,
    this.accelZ = 0,
    this.heading = 0,
    this.lastUpdate,
    this.isCollecting = false,
    this.address = 'Carregando...',
  });

  TelemetryData copyWith({
    Position? position,
    double? speed,
    double? accelX,
    double? accelY,
    double? accelZ,
    double? heading,
    DateTime? lastUpdate,
    bool? isCollecting,
    String? address,
  }) {
    return TelemetryData(
      position: position ?? this.position,
      speed: speed ?? this.speed,
      accelX: accelX ?? this.accelX,
      accelY: accelY ?? this.accelY,
      accelZ: accelZ ?? this.accelZ,
      heading: heading ?? this.heading,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      isCollecting: isCollecting ?? this.isCollecting,
      address: address ?? this.address,
    );
  }
}
