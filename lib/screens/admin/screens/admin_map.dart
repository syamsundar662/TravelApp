// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class Mapselecter extends StatefulWidget {
//   const Mapselecter({super.key});

//   @override
//   State<Mapselecter> createState() => _MapselecterState();
// }

// class _MapselecterState extends State<Mapselecter> {
//   GoogleMapController? mapController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea (
//         child: Column(
//           children: [ 
             
//             SearchMapPlaceWidget(
//               hasClearButton: true, 
//               placeType: PlaceType.address,  
//               placeholder: 'Enter the location',
//               apiKey: 'AIzaSyDRCUR8N7Upq6to_byI9gynQwzZMKYmpqI',
//               onSelected: (place) async { 
//                 Geolocation? geolocation = await place.geolocation;

//                 // Ensure mapController is not null before using it
//                 if (geolocation != null && mapController != null) {
//                   mapController!.animateCamera(
//                     CameraUpdate.newLatLng(geolocation.coordinates), 
//                   );
//                   mapController!.animateCamera(
//                     CameraUpdate.newLatLngBounds(geolocation.bounds, 0),
//                   );
//                 }
//               },
//             ),
//             Expanded(
//               child: GoogleMap(
//                 onMapCreated: (GoogleMapController googleMapController) {
//                   setState(() {
//                     mapController = googleMapController;
//                   });
//                 },
//                 mapType: MapType.satellite,
//                 initialCameraPosition: CameraPosition(
//                   zoom: 15,
//                   target: LatLng(9.686181399999999, 76.9052294),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// //  markers: {
// //                     Marker(
// //                       markerId: MarkerId('marker'),
// //                       position: LatLng(9.686181399999999, 76.9052294),
// //                     ),
// //                   },