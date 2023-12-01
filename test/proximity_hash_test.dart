import 'package:test/test.dart';
import 'package:proximity_hash/proximity_hash.dart';

void main() {
  group('In circle tests', () {
    test('in circle check is true', () {
      bool check = inCircleCheck(12, 77, 12.1, 77, 100);
      assert(check);
    });
    test('in circle check is false', () {
      bool check = inCircleCheck(12, 77, 23, 87, 1);
      assert(!check);
    });
  });
  group('Centroid tests', () {
    test('get centroid', () {
      List<double?> centroid = getCentroid(10, 10, 10, 10);
      assert(centroid[0] == 15.0);
      assert(centroid[1] == 15.0);
    });
  });
  group('Lat Lng Conversion tests', () {
    test('convert to geohash', () {
      String geohash = convertToGeohash(1000.0, 1000.0, 12.0, 77.0, 10);
      assert(geohash == "tdnu26hmkq");
    });
  });
  group('create geohash tests', () {
    test('create geohash', () {
      List<String> geohashes = createGeohashes(48.858156, 2.294776, 100, 3);
      assert(geohashes.length == 2);
      assert(geohashes.contains("u0d"));
      assert(geohashes.contains("u09"));
    });
    test('create multiple geohashes', () {
      List<String> geohashes =
          createGeohashes(43.649093099999995, -79.42056769999999, 4000, 5);
      assert(geohashes.length == 9);
      assert(geohashes.contains("dpz83"));
    });
    test('create geohash bounding box', () {
      List<String> geohashes = createGeohashesBoundingBox(
          47.858156, 1.294776, 49.858156, 3.294776, 3);
      assert(geohashes.length == 2);
      assert(geohashes.contains("u0d"));
      assert(geohashes.contains("u09"));
    });
  });
}
