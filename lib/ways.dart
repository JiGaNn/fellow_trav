import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WaysPage extends StatefulWidget {
  const WaysPage({Key? key}) : super(key: key);

  @override
  State<WaysPage> createState() => _WaysPageState();
}

class _WaysPageState extends State<WaysPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder (
            stream : FirebaseFirestore.instance.collection('ways').snapshots(),
            builder : (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot ) {
              if (!snapshot.hasData) return Text('Hет зanиceй');
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                        key: Key(snapshot.data?.docs[index].id as String),
                        child: Column(
                          children: [
                            Card(
                              color: Color.fromRGBO(16, 168, 229, 1),
                              child: ListTile(
                                title: Column(
                                  children: [
                                    Text("От: "+snapshot.data?.docs[index].get('from')),
                                    Text("Куда: "+snapshot.data?.docs[index].get('to')),
                                    Text("Дата: "+snapshot.data?.docs[index].get('date')),
                                    Text("Время: "+snapshot.data?.docs[index].get('time')),
                                    Text("Максимальное число пассажиров: "+(snapshot.data?.docs[index].get('max_pas').toString() as String))
                                  ],
                                ),
                                trailing: IconButton(icon: Icon(Icons.delete_sweep, color: Color.fromRGBO(76, 80, 95, 1)), // Icon
                                  onPressed : ( ) {
                                    setState ((){
                                      FirebaseFirestore.instance.collection('ways').doc(snapshot.data?.docs[index].id).delete();
                                    });
                                  },
                                ), // IconButton
                              ), // ListTile
                            ),
                          ],
                        ),
                        onDismissed: (direction) {
                          FirebaseFirestore.instance.collection('ways').doc(snapshot.data?.docs[index].id).delete();
                        }
                    );
                  }
              );
            }
        )
    );
  }
}
