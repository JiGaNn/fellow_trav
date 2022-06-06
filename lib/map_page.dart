import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapObjectId mapObjectId = MapObjectId('');
  final TextEditingController queryController = TextEditingController();
  final animation = MapAnimation(type: MapAnimationType.smooth, duration: 2.0);
  late YandexMapController controller;
  var point;

  final List<MapObject> mapObjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: <Widget>[
              Expanded(
                  child: Stack(
                      children: [
                        YandexMap(
                            mapObjects: mapObjects,
                            onMapCreated: (YandexMapController yandexMapController) async {
                              controller = yandexMapController;
                              await controller.moveCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(target: Point(latitude: 52.29, longitude: 104.28))),
                                  animation: animation
                              );
                            }
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Card(
                            child: TextField(
                              style: const TextStyle(
                                  fontFamily: "SFProDisplay",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color.fromRGBO(76, 80, 95, 1)
                              ),
                              controller: queryController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.location_on_outlined),
                                hintText: "Search for location",
                                hintStyle: TextStyle(
                                  fontFamily: "SFProDisplay",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14
                                ),
                                contentPadding: EdgeInsets.all(16.0),
                              ),
                              onEditingComplete: () async {
                                final query = queryController.text;
                                print('Search query: $query');
                                final resultWithSession = YandexSearch.searchByText(
                                  searchText: query,
                                  geometry: Geometry.fromBoundingBox(
                                      BoundingBox(
                                        southWest: Point(latitude: 55.76996383933034, longitude: 37.57483142322235),
                                        northEast: Point(latitude: 55.785322774728414, longitude: 37.590924677311705),
                                      )
                                  ),
                                  searchOptions: SearchOptions(
                                    searchType: SearchType.geo,
                                    geometry: false,
                                  ),
                                );
                                //resultWithSession.session.
                                point = (await resultWithSession.result as SearchSessionResult).items?.first.geometry.first.point;
                                print((await resultWithSession.result as SearchSessionResult).items?.first.toponymMetadata!.address.formattedAddress);
                                mapObjectId = MapObjectId(((await resultWithSession.result as SearchSessionResult).items?.first.toponymMetadata!.address.formattedAddress as String));
                                await controller.moveCamera(
                                    CameraUpdate.newCameraPosition(CameraPosition(target: point)),
                                    animation: animation
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 15.0),
                          child: IconButton(
                            icon: Icon(Icons.add_circle_outline_outlined),
                            color: Colors.blueGrey.withOpacity(0.8),
                            iconSize: 70,
                            onPressed: () async {
                              if (mapObjects.any((el) => el.mapId == mapObjectId)) {
                                return;
                              }
                              final mapObject = PlacemarkMapObject(
                                  mapId: mapObjectId,
                                  point: point,
                                  consumeTapEvents: true,
                                  onTap: (PlacemarkMapObject self, Point _point) {
                                    var mapObjectIdDelete = MapObjectId('$_point');
                                    final mapObject =
                                    PlacemarkMapObject(
                                      mapId: mapObjectIdDelete,
                                      point: _point,
                                      icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                          image: BitmapDescriptor.fromAssetImage('lib/assets/place.png'),
                                        scale: 0.9
                                      )),
                                      onTap: deleteMarkers(mapObjectIdDelete, self.mapId),
                                    );
                                    mapObjects.add(mapObject);
                                    print('Tapped me at $_point');
                                  },
                                  opacity: 0.7,
                                  icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                      image: BitmapDescriptor.fromAssetImage('lib/assets/place.png'),
                                      scale: 0.9,
                                      rotationType: RotationType.rotate
                                  ))
                              );
                              setState(() {
                                mapObjects.add(mapObject);
                              });
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 95.0),
                          child: IconButton(
                            icon: Icon(Icons.directions_car_outlined),
                            color: Colors.blueGrey.withOpacity(0.8),
                            iconSize: 70,
                            onPressed: () async {
                              if (mapObjects.any((el) => el.mapId == mapObjectId)) {
                                return;
                              }
                              final mapObject = PlacemarkMapObject(
                                  mapId: mapObjectId,
                                  point: point,
                                  consumeTapEvents: true,
                                  onTap: (PlacemarkMapObject self, Point _point) {
                                    var mapObjectIdDelete = MapObjectId('$_point');
                                    final mapObject =
                                    PlacemarkMapObject(
                                      mapId: mapObjectIdDelete,
                                      point: _point,
                                      icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                          image: BitmapDescriptor.fromAssetImage('lib/assets/car.png'),
                                          scale: 0.17
                                      )),
                                      onTap: deleteMarkers(mapObjectIdDelete, self.mapId),
                                    );
                                    mapObjects.add(mapObject);
                                    print('Tapped me at $_point');
                                  },
                                  opacity: 0.9,
                                  icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                      image: BitmapDescriptor.fromAssetImage('lib/assets/car.png'),
                                      scale: 0.17,
                                      rotationType: RotationType.rotate
                                  ))
                              );
                              setState(() {
                                mapObjects.add(mapObject);
                              });
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 15.0),
                          child: IconButton(
                            icon: Icon(Icons.chat_outlined),
                            color: Colors.blueGrey.withOpacity(0.8),
                            iconSize: 70,
                            onPressed: () {},
                          ),
                        ),
                      ]
                  )
              )
            ]
        )
    );
  }

  deleteMarkers(MapObjectId mapObjectIdDelete, MapObjectId mapObjectId) async{
    setState(() {
      mapObjects.removeWhere((el) => el.mapId == mapObjectIdDelete);
      mapObjects.removeWhere((el) => el.mapId == mapObjectId);
    });
  }
}