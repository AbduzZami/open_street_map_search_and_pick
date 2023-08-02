A flutter place search and location picker plugin that uses Open Street Map.
it is completely free and easy to use.

## Features

* Pick location from map
* Search location by places
* Easy to use




## Demo
![open street map search and pick](https://user-images.githubusercontent.com/69592754/179368498-fe392cdb-c321-46e8-ac4d-6b816e0a3758.png)


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
            buttonColor: Colors.blue,
            buttonText: 'Set Current Location',
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
            buttonColor: Colors.blue,
            buttonText: 'Set Current Location',
            onPicked: (pickedData) {
              print(pickedData.latLong.latitude);
              print(pickedData.latLong.longitude);
              print(pickedData.address);
            })

You can get latitude, longitude and address like that.

# Video Tutorial
Click on the image below to view a video tutorial. It will redirect you to a youtube video.
* Video 1

[![Click here to view the tutorial](https://img.youtube.com/vi/VHDlC8wC9FI/0.jpg)](https://www.youtube.com/watch?v=VHDlC8wC9FI)

* Video 2

[![Click here to view the tutorial](https://img.youtube.com/vi/kZRrH3UlxeU/0.jpg)](https://www.youtube.com/watch?v=kZRrH3UlxeU)


# Contributors

<a href="https://github.com/AbduzZami"><img src="https://avatars.githubusercontent.com/u/69592754?v=4" title="AbduzZami" width="80" height="80"></a>
<a href="https://github.com/ZdenekKrcal"><img src="https://avatars.githubusercontent.com/u/51366376?v=4" title="ZdenekKrcal" width="80" height="80"></a>
<a href="https://github.com/FlorianPix"><img src="https://avatars.githubusercontent.com/u/34790464?v=4" title="FlorianPix" width="80" height="80"></a>
<a href="https://github.com/A7MeDG0L0L"><img src="https://avatars.githubusercontent.com/u/33913003?v=4" title="Ahmed Galal" width="80" height="80"></a>
<a href="https://github.com/rlbartz"><img src="https://avatars.githubusercontent.com/u/2353852?v=4" title="rlbartz" width="80" height="80"></a>
<a href="https://github.com/mz2"><img src="https://avatars.githubusercontent.com/u/71363?v=4" title="mz2" width="80" height="80"></a>
<a href="https://github.com/bartzdev"><img src="https://avatars.githubusercontent.com/u/69410101?v=4" title="bartzdev" width="80" height="80"></a>
<a href="https://github.com/Sanat2002"><img src="https://avatars.githubusercontent.com/u/76841209?v=4" title="Sanat2002" width="80" height="80"></a>
<a href="https://github.com/MuhammadAzharUmar"><img src="https://avatars.githubusercontent.com/u/83802823?v=4" title="MuhammadAzharUmar" width="80" height="80"></a>

