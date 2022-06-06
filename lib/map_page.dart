import 'dart:math';
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
                            onPressed: () {
                              _requestRoutes;
                            },
                          ),
                        ),
                      ]
                  )
              )
            ]
        )
    );
  }

  final PlacemarkMapObject startPlacemark = PlacemarkMapObject(
    mapId: MapObjectId('start_placemark'),
    point: Point(latitude: 52.2, longitude: 104.2),
    icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('lib/assets/route_start.png'),
            scale: 0.3
        )
    ),
  );
  final PlacemarkMapObject stopByPlacemark = PlacemarkMapObject(
    mapId: MapObjectId('stop_by_placemark'),
    point: Point(latitude: 52.29, longitude: 104.28),
    icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('lib/assets/route_start.png'),
            scale: 0.3
        )
    ),
  );
  final PlacemarkMapObject endPlacemark = PlacemarkMapObject(
      mapId: MapObjectId('end_placemark'),
      point: Point(latitude: 52.4, longitude: 104.32),
      icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('lib/assets/route_start.png'),
              scale: 0.3
          )
      )
  );

  Future<void> _requestRoutes() async {
    var resultWithSession = YandexDriving.requestRoutes(
        points: [
          RequestPoint(point: startPlacemark.point, requestPointType: RequestPointType.wayPoint),
          RequestPoint(point: stopByPlacemark.point, requestPointType: RequestPointType.viaPoint),
          RequestPoint(point: endPlacemark.point, requestPointType: RequestPointType.wayPoint),
        ],
        drivingOptions: DrivingOptions(
            initialAzimuth: 0,
            routesCount: 5,
            avoidTolls: true
        )
    );
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => _SessionPage(
                startPlacemark,
                endPlacemark,
                resultWithSession.session,
                resultWithSession.result
            )
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


class _SessionPage extends StatefulWidget {
  final Future<DrivingSessionResult> result;
  final DrivingSession session;
  final PlacemarkMapObject startPlacemark;
  final PlacemarkMapObject endPlacemark;

  _SessionPage(this.startPlacemark, this.endPlacemark, this.session, this.result);

  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<_SessionPage> {
  late final List<MapObject> mapObjects = [
    widget.startPlacemark,
    widget.endPlacemark
  ];

  final List<DrivingSessionResult> results = [];
  bool _progress = true;

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  void dispose() {
    super.dispose();

    _close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Driving ${widget.session.id}')),
        body: Container(
            padding: EdgeInsets.all(8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        YandexMap(
                            mapObjects: mapObjects
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                              children: <Widget>[
                                SizedBox(
                                    height: 60,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        !_progress ? Container() : TextButton.icon(
                                            icon: CircularProgressIndicator(),
                                            label: Text('Cancel'),
                                            onPressed: _cancel
                                        )
                                      ],
                                    )
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: _getList(),
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                          )
                      )
                  )
                ]
            )
        )
    );
  }

  List<Widget> _getList() {
    final list = <Widget>[];

    if (results.isEmpty) {
      list.add((Text('Nothing found')));
    }

    for (var r in results) {
      list.add(Container(height: 20));

      r.routes!.asMap().forEach((i, route) {
        list.add(Text('Route $i: ${route.metadata.weight.timeWithTraffic.text}'));
      });

      list.add(Container(height: 20));
    }

    return list;
  }

  Future<void> _cancel() async {
    await widget.session.cancel();

    setState(() { _progress = false; });
  }

  Future<void> _close() async {
    await widget.session.close();
  }

  Future<void> _init() async {
    await _handleResult(await widget.result);
  }

  Future<void> _handleResult(DrivingSessionResult result) async {
    setState(() { _progress = false; });

    if (result.error != null) {
      print('Error: ${result.error}');
      return;
    }

    setState(() { results.add(result); });
    setState(() {
      result.routes!.asMap().forEach((i, route) {
        mapObjects.add(PolylineMapObject(
          mapId: MapObjectId('route_${i}_polyline'),
          polyline: Polyline(points: route.geometry),
          strokeColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          strokeWidth: 3,
        ));
      });
    });
  }
}