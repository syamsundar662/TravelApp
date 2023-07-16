// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class DestinationFB {
//   String placeName;
//   String location;
//   String district;
//   String category;
//   String description;
//   String? id;
//   String reachthere;
//   List<String> imageUrls;

//   DestinationFB({
//     required this.placeName,
//     required this.location,
//     required this.district,
//     required this.category,
//     required this.description,
//     required this.reachthere,
//     this.id,
//     required this.imageUrls,
//   });
// }

// class trypage extends StatelessWidget {
//   final CollectionReference collectionReference =
//       FirebaseFirestore.instance.collection('destinations');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ValueListenableBuilder<QuerySnapshot>(
//         valueListenable: collectionReference.snapshots(),
//         builder: (context, snapshot, _) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
    
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           }
    
//           List<DestinationFB> destinations = snapshot.datass!.docs.map(
//             (doc) {
//               Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//               return DestinationFB(
//                 placeName: data['placeName'],
//                 location: data['location'],
//                 district: data['district'],
//                 category: data['category'],
//                 description: data['description'],
//                 reachthere: data['reachthere'],
//                 id: doc.id,
//                 imageUrls: List<String>.from(data['imageUrls']),
//               );
//             },
//           ).toList();
    
//           return ListView.builder(
//             itemCount: destinations.length,
//             itemBuilder: (context, index) {
//               DestinationFB destination = destinations[index];
//               return ListTile(
//                 title: Text(destination.placeName),
//                 subtitle: Text(destination.location),
//                 // Display other properties as needed
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
