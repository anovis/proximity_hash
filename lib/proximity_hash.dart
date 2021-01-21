import 'dart:math';
import 'dart:collection';
import 'package:dart_geohash/dart_geohash.dart';

GeoHasher geoHasher = GeoHasher();

/// Get centroid
List<double> getCentroid(latitude, longitude, height, width) {
  double centeredY = latitude + (height / 2);
  double centeredX = longitude + (width / 2);

  return [centeredX, centeredY];
}

/// Check to see if a point is contained in a circle
bool inCircleCheck(double latitude, double longitude, double centerLat,
    double centerLon, double radius) {
  double xDiff = longitude - centerLon;
  double yDiff = latitude - centerLat;

  if (pow(xDiff, 2) + pow(yDiff, 2) <= pow(radius, 2)) {
    return true;
  }

  return false;
}

/// Convert location point to geohash taking into account Earth curvature
String convertToGeohash(y, x, latitude, longitude, int precision) {
  double pi = 3.14159265359;

  double rEarth = 6371000;

  double latDiff = (y / rEarth) * (180 / pi);
  double lonDiff = (x / rEarth) * (180 / pi) / cos(latitude * pi / 180);

  double finalLat = latitude + latDiff;
  double finalLon = longitude + lonDiff;

  return geoHasher.encode(finalLon, finalLat, precision: precision);
}

// Generate geohashes based on radius in meters
List<String> createGeohashes(
    double latitude, double longitude, double radius, int precision) {
  if (precision > 12 || precision < 0) {
    throw ArgumentError('Incorrect precision found');
  }

  double x = 0.0;
  double y = 0.0;

  HashSet<String> geohashes = HashSet();

  List<double> gridWidth = [
    5009400.0,
    1252300.0,
    156500.0,
    39100.0,
    4900.0,
    1200.0,
    152.9,
    38.2,
    4.8,
    1.2,
    0.149,
    0.0370
  ];
  List<double> gridHeight = [
    4992600.0,
    624100.0,
    156000.0,
    19500.0,
    4900.0,
    609.4,
    152.4,
    19.0,
    4.8,
    0.595,
    0.149,
    0.0199
  ];

  double height = (gridHeight[precision - 1]) / 2;
  double width = (gridWidth[precision - 1]) / 2;

  int latMoves = (radius / height).ceil();
  int lonMoves = (radius / width).ceil();

  for (var i = 0; i < latMoves; i++) {
    double tempLat = y + height * i;
    for (var j = 0; j < lonMoves; j++) {
      double tempLong = y + width * j;

      if (inCircleCheck(tempLat, tempLong, y, x, radius)) {
        List<double> centerList = getCentroid(tempLat, tempLong, height, width);
        double centerX = centerList[0];
        double centerY = centerList[1];

        geohashes.addAll([
          convertToGeohash(centerY, centerX, latitude, longitude, precision),
          convertToGeohash(-centerY, centerX, latitude, longitude, precision),
          convertToGeohash(centerY, -centerX, latitude, longitude, precision),
          convertToGeohash(-centerY, -centerX, latitude, longitude, precision),
        ]);
      }
    }
  }
  return geohashes.toList();
}
