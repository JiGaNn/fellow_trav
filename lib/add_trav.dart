import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:date_field/date_field.dart';
import 'package:yand_map/MapPoint.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class AddTrav extends StatefulWidget {
  const AddTrav({Key? key}) : super(key: key);

  @override
  State<AddTrav> createState() => _AddTravState();
}

class _AddTravState extends State<AddTrav> {

  final controllerFrom = TextEditingController();
  final controllerTo = TextEditingController();
  String controllerDate = "";
  String controllerTime = "";
  late int maxPassager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(19, 55, 19, 15),
        reverse: true,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/map');
                },
                icon: Image.asset("lib/assets/arrow.png"),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 25.0)),
            TextField(
              controller: controllerFrom,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(76, 80, 95, 1)
              ),
              decoration: InputDecoration(
                labelText: "Откуда",
                labelStyle: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(149, 149, 149, 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(76, 80, 95, 1), width: 2),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            TextField(
              controller: controllerTo,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(76, 80, 95, 1)
              ),
              decoration: InputDecoration(
                labelText: "Куда",
                labelStyle: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(149, 149, 149, 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(76, 80, 95, 1), width: 2),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Align(
              alignment: Alignment.centerLeft,
              child: DateTimeFormField(
                onDateSelected: (DateTime? date) {
                  controllerDate = date.toString().trim();
                },
                dateTextStyle: TextStyle(
                    fontFamily: "SFProDisplay",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color.fromRGBO(76, 80, 95, 1)
                ),
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: "SFProDisplay",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color.fromRGBO(149, 149, 149, 1),
                  ),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    borderSide: BorderSide(color: Color.fromRGBO(76, 80, 95, 1), width: 2),
                  ),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Дата',
                    constraints: BoxConstraints(
                        maxWidth: 170
                    )
                ),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Align(
              alignment: Alignment.centerLeft,
              child: DateTimeFormField(
                onDateSelected: (DateTime? date) {
                  controllerTime = date.toString().trim();
                },
                dateTextStyle: TextStyle(
                    fontFamily: "SFProDisplay",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color.fromRGBO(76, 80, 95, 1)
                ),
                decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      fontFamily: "SFProDisplay",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color.fromRGBO(149, 149, 149, 1),
                    ),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(color: Color.fromRGBO(76, 80, 95, 1), width: 2),
                    ),
                    suffixIcon: Icon(Icons.access_time_outlined),
                    labelText: 'Время выезда',
                    constraints: BoxConstraints(
                        maxWidth: 170
                    )
                ),
                mode: DateTimeFieldPickerMode.time,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20.0)),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                maxPassager = int.parse(value.trim());
              },
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(76, 80, 95, 1)
              ),
              decoration: InputDecoration(
                labelText: "Макс. пассажиров",
                labelStyle: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(149, 149, 149, 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(76, 80, 95, 1), width: 2),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20.0)),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 13, bottom: 7),
                child: const Text("Необязательно*",
                    style: TextStyle(
                      fontFamily: "SFProDisplay",
                      fontWeight: FontWeight.w800,
                      color: Color.fromRGBO(76, 80, 95, 0.8),
                      fontSize: 12,
                    )
                ),
              ),
            ),
            TextField(
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(76, 80, 95, 1)
              ),
              decoration: InputDecoration(
                labelText: "Марка автомобиля",
                labelStyle: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(149, 149, 149, 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(76, 80, 95, 1), width: 2),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            TextField(
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(76, 80, 95, 1)
              ),
              decoration: InputDecoration(
                labelText: "Модель автомобиля",
                labelStyle: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(149, 149, 149, 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(76, 80, 95, 1), width: 2),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 50.0)),
            ElevatedButton(
                onPressed: () {
                  addWay();
                  addTrav();
                  Navigator.pushReplacementNamed(context, '/map');
                },
                child: const Text("Создать поездку",
                  style: TextStyle(
                      fontFamily: "SFProDisplay",
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                  ),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: const BorderSide(color: Color.fromRGBO(16, 168, 229, 1)),
                        )
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(Size(200, 50))
                )
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addTrav() async {
    var query = controllerFrom.text;
    print('Search query: $query');
    var resultWithSession = YandexSearch.searchByText(
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
    print((await resultWithSession.result as SearchSessionResult).items?.first.toponymMetadata!.address.formattedAddress);
    MapPoint.pointFrom = (await resultWithSession.result as SearchSessionResult).items?.first.geometry.first.point as Point;
    var from = ((await resultWithSession.result as SearchSessionResult).items?.first.toponymMetadata!.address.formattedAddress as String);
    
    query = controllerTo.text;
    print('Search query: $query');
    resultWithSession = YandexSearch.searchByText(
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
    print((await resultWithSession.result as SearchSessionResult).items?.first.toponymMetadata!.address.formattedAddress);
    MapPoint.pointTo = (await resultWithSession.result as SearchSessionResult).items?.first.geometry.first.point as Point;
    var to = ((await resultWithSession.result as SearchSessionResult).items?.first.toponymMetadata!.address.formattedAddress as String);
    
    MapPoint.mapObjectIdFrom = MapObjectId(from+to);
    MapPoint.mapObjectIdTo = MapObjectId(to+from);
    MapPoint.drawPoint();
  }
  Future addWay() async {
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection("ways").doc(user?.uid).set({
        'uid': user?.uid,
        'from': controllerFrom.text.trim(),
        'to': controllerTo.text.trim(),
        'date': controllerDate,
        'time': controllerTime,
        'max_pas': maxPassager
      });
  }
}
//evgenij29082002@gmail.com
//Irkutsk Novatorov 33
//Irkutsk Lenina 36