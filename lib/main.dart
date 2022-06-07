import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yand_map/add_trav.dart';
import 'package:yand_map/registration_page.dart';
import 'package:yand_map/welcome_page.dart';
import 'map_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const WelcomePage(),
      '/reg': (context) => const RegistrationPage(),
      '/map': (context) => MapPage(),
      '/add_trav': (context) => const AddTrav(),
    },
  ));
}


