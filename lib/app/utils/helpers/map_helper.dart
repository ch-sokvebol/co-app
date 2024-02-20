import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapHelperController extends GetxController {
  onOpenLocationSetting() async {
    return showCupertinoDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('"CO App" need to access your current location'),
        content: const Text(
            'Please allow location permission to access your current location. Your current location will displayed on the map and use for directions'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              await Geolocator.openLocationSettings().then((value) {
                Navigator.pop(context);
              });
            },
            child: const Text('Go to setting'),
          )
        ],
      ),
    );
  }

  final currentLatStore = ''.obs;
  final currentLngStore = ''.obs;
  double latitute = 11.587542;
  double longtitute = 104.897149;
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        onOpenLocationSetting();

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      onOpenLocationSetting();

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position currentLocation = await Geolocator.getCurrentPosition();
    currentLatStore.value = currentLocation.latitude.toString();
    currentLngStore.value = currentLocation.longitude.toString();
    latitute = currentLocation.latitude;
    longtitute = currentLocation.longitude;
    update();
    return currentLocation;
  }

  late Position? position;
  late List<Placemark> address;
  Future<List<Placemark>> onAdd() async {
    address = await placemarkFromCoordinates(latitute, longtitute);
    debugPrint('address: $address');

    return address;
  }
}
