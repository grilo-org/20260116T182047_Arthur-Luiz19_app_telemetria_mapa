import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:telemetria/models/telemetry_model.dart';
import '../services/address_service.dart';
import '../utils/compass_utils.dart';
import '../utils/acceleration_utils.dart';

class TelemetryProvider extends ChangeNotifier {
  TelemetryData _data = TelemetryData();

  Position? get position => _data.position;
  double get speed => _data.speed;
  double get heading => _data.heading;
  bool get isCollecting => _data.isCollecting;
  String get address => _data.address;

  String get lastUpdateString {
    if (_data.lastUpdate == null) return '--';
    final diff = DateTime.now().difference(_data.lastUpdate!).inSeconds;
    return 'Atualizado há ${diff}s';
  }

  double get acceleration =>
      AccelerationUtils.getAccelerationWithoutGravity(
        _data.accelX,
        _data.accelY,
        _data.accelZ,
      );

  String get direction => CompassUtils.getCardinalDirection(_data.heading);

  StreamSubscription<Position>? _positionSub;
  StreamSubscription<AccelerometerEvent>? _accelSub;

  Future<void> start() async {
    final permission = await _requestLocationPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return;
    }

    _updateData(isCollecting: true);
    notifyListeners();

    _positionSub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 15,
      ),
    ).listen((pos) {
      _updateData(
        position: pos,
        speed: (pos.speed * 3.6).clamp(0, double.infinity),
        heading: pos.heading,
        lastUpdate: DateTime.now(),
      );
      notifyListeners();

      AddressService.getAddressFromLatLng(pos.latitude, pos.longitude)
          .then((addr) {
        _updateData(address: addr);
        notifyListeners();
      });
    });

    _accelSub = accelerometerEventStream().listen((event) {
      _updateData(
        accelX: event.x,
        accelY: event.y,
        accelZ: event.z,
      );
      notifyListeners();
    });
  }

  Future<LocationPermission> _requestLocationPermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }

  void _updateData({
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
    _data = _data.copyWith(
      position: position,
      speed: speed,
      accelX: accelX,
      accelY: accelY,
      accelZ: accelZ,
      heading: heading,
      lastUpdate: lastUpdate,
      isCollecting: isCollecting,
      address: address,
    );
  }

  void stop() {
    _updateData(isCollecting: false);
    _positionSub?.cancel();
    _accelSub?.cancel();
    notifyListeners();
  }
}