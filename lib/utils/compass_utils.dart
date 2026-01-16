class CompassUtils {
  static String getCardinalDirection(double heading) {
    if (heading.isNaN) return '--';
    final directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    int index = ((heading % 360) / 45).round() % 8;
    return '${directions[index]} (${heading.toStringAsFixed(0)}°)';
  }
}
