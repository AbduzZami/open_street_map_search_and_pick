import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:open_street_map_search_and_pick/models/latlong.dart';
import 'package:open_street_map_search_and_pick/widgets/wide_button.dart';

import 'models/osmdata.dart';
import 'models/pickeddata.dart';

class OpenStreetMapSearchAndPick extends StatefulWidget {
  final LatLong center;
  final void Function(PickedData pickedData) onPicked;
  const OpenStreetMapSearchAndPick(
      {Key? key, required this.center, required this.onPicked})
      : super(key: key);

  @override
  State<OpenStreetMapSearchAndPick> createState() =>
      _OpenStreetMapSearchAndPickState();
}

class _OpenStreetMapSearchAndPickState
    extends State<OpenStreetMapSearchAndPick> {
  MapController _mapController = MapController();
  TextEditingController _searchController = TextEditingController();

  // void TakeToCurrentLocation() async {
  //   LocationPermission permission = await Geolocator.requestPermission();
  //   if (permission != LocationPermission.deniedForever &&
  //       permission != LocationPermission.denied) {
  //     if (kDebugMode) {
  //       print('Permission granted');
  //     }
  //     var position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     var lat = position.latitude;
  //     var long = position.longitude;
  //     _mapController.move(LatLng(lat, long), 15);
  //     setNameCurrentPos();
  //   } else {
  //     if (kDebugMode) {
  //       print('Permission denied');
  //     }
  //   }
  // }

  void setNameCurrentPos() async {
    var client = http.Client();
    double latitude = _mapController.center.latitude;
    double longitude = _mapController.center.longitude;
    print(latitude);
    print(longitude);
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${latitude}&lon=${longitude}&zoom=18&addressdetails=1';

    var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

    _searchController.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
  }

  void setNameCurrentPosAtInit() async {
    var client = http.Client();
    double latitude = widget.center.latitude;
    double longitude = widget.center.longitude;
    print(latitude);
    print(longitude);
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${latitude}&lon=${longitude}&zoom=18&addressdetails=1';

    var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

    _searchController.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
  }

  @override
  void initState() {
    // TODO: implement initState
    _mapController = MapController();

    _mapController.onReady.then((_) {
      setNameCurrentPosAtInit();
    });

    _mapController.mapEventStream.listen((event) async {
      if (event is MapEventMoveEnd) {
        var client = http.Client();
        String url =
            'https://nominatim.openstreetmap.org/reverse?format=json&lat=${event.center.latitude}&lon=${event.center.longitude}&zoom=18&addressdetails=1';

        var response = await client.post(Uri.parse(url));
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes))
            as Map<dynamic, dynamic>;

        _searchController.text = decodedResponse['display_name'];
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
    );
    OutlineInputBorder _inputFocusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 3.0),
    );
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
              child: FlutterMap(
            options: MapOptions(
                center: LatLng(widget.center.latitude, widget.center.longitude),
                zoom: 15.0,
                maxZoom: 18,
                minZoom: 6),
            mapController: _mapController,
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                // attributionBuilder: (_) {
                //   return Text("© OpenStreetMap contributors");
                // },
              ),
              // MarkerLayerOptions(
              //   markers: [
              //     Marker(
              //       width: 80.0,
              //       height: 80.0,
              //       point: LatLng(51.5, -0.09),
              //       builder: (ctx) => Container(
              //         child: FlutterLogo(),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          )),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.all(15),
              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _searchController,
                    decoration: InputDecoration(
                        labelText: 'Search Location',
                        border: _inputBorder,
                        focusedBorder: _inputFocusBorder)),
                suggestionsCallback: (pattern) async {
                  // return CitiesService.getSuggestions(pattern);
                  var client = http.Client();
                  try {
                    // var response = await client.post(
                    //     Uri.https('nominatim.openstreetmap.org', 'search'),
                    //     body: {
                    //       'q': 'tala',
                    //       'format': 'json',
                    //       'polygon_geojson': '1',
                    //       'addressdetails': '1'
                    //     });
                    String url =
                        'https://nominatim.openstreetmap.org/search?q=' +
                            pattern +
                            '&format=json&polygon_geojson=1&addressdetails=1';
                    print(url);
                    var response = await client.post(Uri.parse(url));
                    var decodedResponse =
                        jsonDecode(utf8.decode(response.bodyBytes))
                            as List<dynamic>;
                    print(decodedResponse);
                    return decodedResponse
                        .map((e) => OSMdata(
                            displayname: e['display_name'],
                            lat: double.parse(e['lat']),
                            lon: double.parse(e['lon'])))
                        .toList();
                  } finally {
                    client.close();
                  }
                  // return LoadInSplash.topics.where((element) =>
                  //     element.toLowerCase().contains(pattern.toLowerCase()));
                },
                hideOnEmpty: true,
                itemBuilder: (context, OSMdata suggestion) {
                  return ListTile(
                    title: Text(suggestion.displayname),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (OSMdata suggestion) {
                  _searchController.text = suggestion.displayname;
                  _mapController.move(
                      LatLng(suggestion.lat, suggestion.lon), 15);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select a location';
                  }
                },
                onSaved: (value) {
                  // _topicController.text = value.toString();
                },
              ),
            ),
          ),
          Positioned.fill(
              child: IgnorePointer(
            child: Center(
              child: Icon(
                Icons.location_pin,
                size: 50,
              ),
            ),
          )),
          Positioned(
              bottom: 180,
              right: 5,
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  _mapController.move(
                      _mapController.center, _mapController.zoom + 1);
                },
                child: Icon(Icons.zoom_in_map),
              )),
          Positioned(
              bottom: 120,
              right: 5,
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  _mapController.move(
                      _mapController.center, _mapController.zoom - 1);
                },
                child: Icon(Icons.zoom_out_map),
              )),
          // Positioned(
          //     bottom: 60,
          //     right: 5,
          //     child: FloatingActionButton(
          //       backgroundColor: Theme.of(context).primaryColor,
          //       onPressed: () {
          //         TakeToCurrentLocation();
          //       },
          //       child: Icon(Icons.my_location),
          //     )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: WideButton('Set Current Location', onPressed: () async {
                  pickData().then((value) {
                    widget.onPicked(value);
                  });
                }, backgroundcolor: Theme.of(context).primaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<PickedData> pickData() async {
    LatLong center = LatLong(
        _mapController.center.latitude, _mapController.center.longitude);
    var client = http.Client();
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${_mapController.center.latitude}&lon=${_mapController.center.longitude}&zoom=18&addressdetails=1';

    var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
    String displayName = decodedResponse['display_name'];
    return PickedData(center, displayName);
  }
}
