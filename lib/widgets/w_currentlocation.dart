import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreens extends StatefulWidget {
  const LocationScreens({super.key});

  @override
  State<LocationScreens> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreens> {
  String address = 'Fetching...';

  @override
  void initState() {
    super.initState();
    getLocationAndAddress();
  }

  Future<void> getLocationAndAddress() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        address = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          address = 'Location permissions are denied.';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        address = 'Location permissions are permanently denied.';
      });
      return;
    }

    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      await getAddressFromLatLong(position);
    } catch (e) {
      // print('Error fetching location: $e');
    }
  }

  Future<void> getAddressFromLatLong(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        address =
            '${place.subLocality},${place.locality},${place.administrativeArea}';
      });
    } catch (e) {
      setState(() {
        address = 'not available.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.my_location_outlined,
            color: Colors.orange,
            size: 15,
          ),
          Text(
            address,
            style: const TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
