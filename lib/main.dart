import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yand_map/add_trav.dart';
import 'package:yand_map/registration_page.dart';
import 'package:yand_map/welcome_page.dart';
import 'map_page.dart';


void main() async {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const AddTrav(),
      '/reg': (context) => const RegistrationPage(),
      '/map': (context) => const MapPage(),
    },
  ));
}


