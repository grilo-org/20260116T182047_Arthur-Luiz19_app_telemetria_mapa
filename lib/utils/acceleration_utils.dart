import 'dart:math';

class AccelerationUtils {
  static double getAccelerationWithoutGravity(
    double accelX,
    double accelY,
    double accelZ,
  ) {
    const gravity = 9.8;
    final total = sqrt(
      accelX * accelX + accelY * accelY + accelZ * accelZ,
    );
    return (total - gravity).abs();
  }
}
