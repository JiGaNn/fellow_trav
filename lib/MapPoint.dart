import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPoint {
  static bool visible = false;
  static MapObjectId mapObjectIdFrom = MapObjectId('');
  static MapObjectId mapObjectIdTo = MapObjectId('');
  static Point pointFrom = Point(latitude: 52.29, longitude: 104.28);
  static Point pointTo = Point(latitude: 52.29, longitude: 104.28);
  static PlacemarkMapObject mapObjectFrom = PlacemarkMapObject(
    onTap: (PlacemarkMapObject placemarkMapObject, Point point) {
      mapObjects.removeWhere((el) => el.mapId == (MapObjectId(mapObjectIdFrom.value + mapObjectIdTo.value)));
    },
      mapId: mapObjectIdFrom,
      point: pointFrom,
      consumeTapEvents: true,
      opacity: 0.7,
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('lib/assets/car.png'),
          scale: 0.17,
          rotationType: RotationType.rotate,
      )),
  );
  static PlacemarkMapObject mapObjectTo = PlacemarkMapObject(
      mapId: mapObjectIdTo,
      point: pointTo,
      consumeTapEvents: true,
      opacity: 0.7,
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('lib/assets/place.png'),
          scale: 0.9,
          rotationType: RotationType.rotate
      ))
  );

  static List<MapObject> mapObjects = [];
  static drawPoint() {
    if (mapObjects.any((el) => el.mapId == mapObjectIdFrom)) {
      return;
    }
    if (mapObjects.any((el) => el.mapId == mapObjectIdTo)) {
      return;
    }
    mapObjectFrom = PlacemarkMapObject(
        mapId: mapObjectIdFrom,
        point: pointFrom,
        consumeTapEvents: true,
        opacity: 0.7,
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('lib/assets/car.png'),
            scale: 0.17,
            rotationType: RotationType.rotate
        ))
    );
    mapObjectTo = PlacemarkMapObject(
        mapId: mapObjectIdTo,
        point: pointTo,
        consumeTapEvents: true,
        opacity: 0.7,
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('lib/assets/place.png'),
            scale: 0.9,
            rotationType: RotationType.rotate
        ))
    );
    mapObjects.add(mapObjectFrom);
    mapObjects.add(mapObjectTo);
  }

}
