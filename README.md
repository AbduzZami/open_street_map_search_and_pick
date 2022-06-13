# Map Picker Flutter
A flutter place search and location picker plugin that uses Open Street Map.
it is completely free and easy to use.

## This works on:
- [x] Android;
- [x] iOS;
- [x] Web;
- [x] Windows;
- [x] Linux;
- [x] MacOS;

![image](https://user-images.githubusercontent.com/69592754/173405489-0dd25380-14fd-4603-b932-4389f057e461.png)

<!-- ## Help Maintenance

I've been maintaining quite many repos these days and burning out slowly. If you could help me cheer up, buying me a cup of coffee will make my life really happy and get much energy out of it.

<a href="https://www.buymeacoffee.com/RtrHv1C" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a> -->

## Objective
This lib was designed to use open street map to set location on Flutter applications for all platforms.

## Getting Started


Import the following package in your dart file

```dart
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
```

To use is simple, just call the widget bellow. You need to pass the default center position of the map and a onPicked method to get the picked position from the map.

    OpenStreetMapSearchAndPick(
            center: LatLong(23, 89),
            onPicked: (pickedData) {
            })

# Then Usage

Now if you press Set Current Loatiion button, you will get the pinned location by onPicked method.

In the onPicked method you will receive pickedData.

pickedData has two properties.

1. latLong
2. address

latLong has two more properties.

1. latitude
2. longitude

For example

    OpenStreetMapSearchAndPick(
            center: LatLong(23, 89),
            onPicked: (pickedData) {
               print(pickedData.latLong.latitude);
               print(pickedData.latLong.longitude);
               print(pickedData.address);
            })

You can get latitude, longitude and address like that.
