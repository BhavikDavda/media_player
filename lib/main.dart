import 'package:flutter/material.dart';
import 'package:music_player/view/screens/homepage.dart';
import 'package:music_player/view/screens/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/" : (context) => SplashScreen(),
      "Homepage" : (context) => Homepage(),


    },
  ));
}