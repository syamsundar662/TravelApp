import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreens extends StatefulWidget {
  const LocationScreens({super.key});

  @override
  State<LocationScreens> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreens> {
   String _address = 'Loading...';

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission;
    // Check if location permissions are granted
    if (!await Geolocator.isLocationServiceEnabled()) {
      setState(() {
        _address = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permissions if not granted
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _address = 'Location permission denied.';
        });
        return;
      }
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Get the current position (latitude and longitude)
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get the address from the latitude and longitude
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Format the address
      Placemark placemark = placemarks.first;
      String formattedAddress =
          "${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";

      setState(() {
        _address = formattedAddress;
      });
    } catch (e) { 
      setState(() {
        _address = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Location and Address'),
      ),
      body: Center(
        child: Text(
          _address,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}