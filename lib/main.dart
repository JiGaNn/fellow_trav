import 'package:flutter/material.dart';
import 'package:yand_map/registration_page.dart';
import 'package:yand_map/welcome_page.dart';
import 'map_page.dart';



void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const WelcomePage(),
    '/reg': (context) => const RegistrationPage(),
    '/map': (context) => const MapPage(),
  },
));


