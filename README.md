# Dart Proximity Hash

![Pub Version](https://img.shields.io/pub/v/proximity_hash)

**Proximity Hash** generates a set of geohashes that cover a circular area, given the center coordinates and the radius. Geohash is a public domain geocode system which encodes a geographic location into a short string of letters and digits and is used as unique identifies and to represent point data in databases.

For example the point

`25.6953° S, 54.4367° W`

will covert to

`6g3mc626`.

## Install

To get this plugin, add `proximity_hash` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/). For example:

```yaml
dependencies:
  proximity_hash: ^1.0.2
```

## Usage

To get all the geohashes within a radius of `5000` meters from the point `25.6953° S, 54.4367° W` with precision `3` simply import the library and call `createGeohashes()`. The precision dictates how long and how many geohashes are returned. For
example a precision of 3 returns geohahses of length 3.

``` dart
import 'package:proximity_hash/proximity_hash.dart';

List<String> proximityGeohashes = createGeohashes(48.864716, 2.349014, 5000, 3);

// proximityGeohashes == ["u0d","u09"]
```

## Issues

Please file any issues, bugs or feature requests as an issue on our [GitHub](https://github.com/anovis/proximity_hash/issues) page.

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature) submit a [pull request](https://github.com/anovis/proximity_hash/pulls).

___

Based on [proximityhash](https://github.com/ashwin711/proximityhash)
