import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/models/osmdata.dart';

class AutocompleteBasicUserExample extends StatelessWidget {
  const AutocompleteBasicUserExample({Key? key}) : super(key: key);

  static const List<OSMdata> loclist = [];

  static String _displayStringForOption(OSMdata option) => option.displayname;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<OSMdata>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<OSMdata>.empty();
        }
        return loclist.where((OSMdata option) {
          return option
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (OSMdata selection) {
        debugPrint('You just selected ${_displayStringForOption(selection)}');
      },
    );
  }
}
