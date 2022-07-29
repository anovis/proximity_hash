import 'package:proximity_hash/proximity_hash.dart';

// get all points within a certain radius

//points
void main() {
  List<List<double>> points = [
    [48.864716, 2.349014],
    [48.864716, 3.349014],
    [58.864716, 2.349014]
  ];

  //get geohashes within 5000 meter
  List<String> proximityGeohashes =
      createGeohashes(48.864716, 2.349014, 5000, 3);
  for (var g in points) {
    if (proximityGeohashes
        .contains(convertToGeohash(0.0, 0.0, g[0], g[1], 3))) {
      print(
          'The coordinates ${g[0].toString()},${g[1].toString()} are within 5000 meters of 48.864716, 2.349014');
    }
  }

  //get geohashes within bounding box meter
  List<String> proximityGeohashesBox =
      createGeohashesBoundingBox(48.864716, 49.864716, 2.349014, 3.349014, 5);
  for (var g in proximityGeohashesBox) {
    print(
        'Geohash ${g} is in box 48.864716, 49.864716, 2.349014, 3.349014 with precision 5');
  }
}
