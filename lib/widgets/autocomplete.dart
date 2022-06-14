import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_street_map_search_and_pick/models/osmdata.dart';
import 'package:http/http.dart' as http;

import '../models/pickeddata.dart';

class AutocompleteOSMdata extends StatelessWidget {
  final void Function(OSMdata osMdata) onPicked;
  const AutocompleteOSMdata({Key? key, required this.onPicked})
      : super(key: key);

  static String _displayStringForOption(OSMdata option) => option.displayname;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<OSMdata>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text == '') {
          return const Iterable<OSMdata>.empty();
        }

        var client = http.Client();
        try {
          String url = 'https://nominatim.openstreetmap.org/search?q=' +
              textEditingValue.text +
              '&format=json&polygon_geojson=1&addressdetails=1';
          print(url);
          var response = await client.post(Uri.parse(url));
          var decodedResponse =
              jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
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
      },
      onSelected: (OSMdata selection) {
        // searchController.text = selection.displayname;
        // mapController.move(LatLng(selection.lat, selection.lon), 15);
        onPicked(selection);
      },
    );
  }
}
