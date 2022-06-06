import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:date_field/date_field.dart';

class AddTrav extends StatefulWidget {
  const AddTrav({Key? key}) : super(key: key);

  @override
  State<AddTrav> createState() => _AddTravState();
}

class _AddTravState extends State<AddTrav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(19, 55, 19, 0),
        reverse: true,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset("lib/assets/arrow.png"),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 25.0)),
            TextField(
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
            const Padding(padding: EdgeInsets.only(bottom: 90.0)),
            ElevatedButton(
                onPressed: () {
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
}
