import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yand_map/MapPoint.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget {

  late DrivingSessionResult result;
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final animation = MapAnimation(type: MapAnimationType.smooth, duration: 2.0);
  late YandexMapController controller;
  final List<DrivingSessionResult> results = [];
  List<MapObject> mapObjects = MapPoint.mapObjects;

  final user = FirebaseAuth.instance.currentUser!;

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
                                  CameraUpdate.newCameraPosition(CameraPosition(target: MapPoint.pointFrom)),
                                  animation: animation
                              );
                              setState(() {
                                if(MapPoint.pointFrom != Point(latitude: 52.29, longitude: 104.28))
                                _requestRoutes();
                              });
                            },
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(217, 217, 217, 1),
                                borderRadius: BorderRadius.vertical(top: Radius.circular(45))
                            ),
                            child: NavigationBar(
                              backgroundColor: Colors.white10,
                              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
                              destinations: [
                                IconButton(
                                  onPressed: () {  },
                                  icon: Icon(Icons.chat_outlined),
                                  iconSize: 40,
                                  color: Color.fromRGBO(16, 168, 229, 1),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/ways');
                                  },
                                  icon: Icon(Icons.alt_route_outlined),
                                  iconSize: 40,
                                  color: Color.fromRGBO(16, 168, 229, 1),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, '/add_trav');
                                  },
                                  icon: Icon(Icons.add_circle_outline),
                                  iconSize: 40,
                                  color: Color.fromRGBO(16, 168, 229, 1),
                                ),
                                IconButton(
                                  onPressed: () {  },
                                  icon: Icon(Icons.person_outline),
                                  iconSize: 40,
                                  color: Color.fromRGBO(16, 168, 229, 1),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]
                  )
              )
            ]
        )
    );
  }

  Future<void> _requestRoutes() async {
    var resultWithSession = YandexDriving.requestRoutes(
        points: [
          RequestPoint(point: MapPoint.pointFrom, requestPointType: RequestPointType.wayPoint),
          RequestPoint(point: MapPoint.pointTo, requestPointType: RequestPointType.wayPoint),
        ],
        drivingOptions: DrivingOptions(
            initialAzimuth: 0,
            routesCount: 5,
            avoidTolls: true
        )
    );
    await _handleResult(await resultWithSession.result);
  }

  Future<void> _handleResult(DrivingSessionResult result) async {
    if (result.error != null) {
      print('Error: ${result.error}');
      return;
    }
    setState(() { results.add(result); });
    setState(() {
      result.routes!.asMap().forEach((i, route) {
        MapPoint.mapObjects.add(PolylineMapObject(
          mapId: MapObjectId('route_${i}_polyline'),
          polyline: Polyline(points: route.geometry),
          strokeColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          strokeWidth: 3,
        ));
      });
    });
  }
  deleteMarkers(MapObjectId mapObjectIdDelete) async{
    setState(() {
      mapObjects.removeWhere((el) => el.mapId == mapObjectIdDelete);
    });
  }
}