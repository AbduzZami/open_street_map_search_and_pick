import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/models/latlong.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import 'models/pickeddata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const OSMsearchpickexample(),
    );
  }
}

class OSMsearchpickexample extends StatefulWidget {
  const OSMsearchpickexample({Key? key}) : super(key: key);

  @override
  State<OSMsearchpickexample> createState() => _OSMsearchpickexampleState();
}

class _OSMsearchpickexampleState extends State<OSMsearchpickexample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenStreetMapSearchAndPick(
        center: LatLong(23.751938967988323, 90.42430760776541),
        onPicked: (pickedData) {
          print(pickedData.latLong.latitude);
          print(pickedData.latLong.longitude);
          print(pickedData.address);
        },
      ),
    );
  }
}
