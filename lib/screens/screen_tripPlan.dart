import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trivo/screens/mapcord.dart';

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> { 
     CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  String _address = 'Loading...';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _address = 'Location services are disabled.';
        });
        return;
      }

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
        title: InkWell(
onTap: () {
  Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationScreens()));  
},
          child: Text('Table Calendar Example')),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Selected Date: ${_selectedDay.toLocal()}'.split(' ')[0],
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              firstDay: DateTime(2022),
              lastDay: DateTime(2023, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                // Use this function to highlight the selected day.
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              calendarStyle: CalendarStyle(
                // Customize your calendar style here.
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                // Customize your days of week style here.
              ),
              headerStyle: HeaderStyle(
                // Customize your header style here.
              ),
            ), 
             Text(
          _address,
          style: TextStyle(fontSize: 18),
        ),
            // You can add more widgets here...
          ],
        ),
      ), 
    );
  }
}