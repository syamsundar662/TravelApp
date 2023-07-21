// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:trivo/database/functions/Firebase/db_manager.dart';
// import 'package:trivo/database/models/fb_model.dart';
// import 'package:trivo/helper/size.dart';
// import 'package:trivo/helper/styling.dart';
// import 'package:trivo/screens/admin/screens/db_admin.dart';

// class GridAdmin extends StatelessWidget {
//   GridAdmin({Key? key, this.catogory, this.district,this.admin=false,this.gridCount=2}) : super(key: key);

//   final Repository repo = Repository();
//   // final CatogoryClass catogoryObject = CatogoryClass();
//   final String? district;
//   final String? catogory;
//   final bool admin;
//   final int gridCount;

//   @override
//   Widget build(BuildContext context) {
// // take data from firebse according to the distict or catagory if necessary
//     Stream<QuerySnapshot<Map<String, dynamic>>> getStream() {
//       Query<Map<String, dynamic>> query =
//           FirebaseFirestore.instance.collection('destinations');
//       if (district != null) {
//         query = query.where('district', isEqualTo: district);
//       }
//       if (catogory != null) {
//         query = query.where('catogory', isEqualTo: catogory);
//       }
//       return query.snapshots();
//     }

//     return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//       stream: getStream(),
//       builder: (context, streamSnapshot) {
//         if (!streamSnapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         final document = streamSnapshot.data!.docs;
//         if (document.isEmpty) {
//           return ListView(
//             children: [
//               const Center(child: Text('Nothing to Show')),
//             ],
//           );
//         }
//         return GridView.builder(
//           itemCount: document.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: gridCount,
//           ),
//           itemBuilder: (context, index) {
//             return TileFavourites(
//               index: index,
//               admin: admin,
//               destination: repo.modelMaker(document[index]),
//             );
//           },
//         );
//       },
//     );
//   }
// }
