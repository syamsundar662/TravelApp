

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:trivo/database/functions/Hive/db_functions.dart';
// import 'package:trivo/database/models/data_model.dart';
// import 'package:trivo/helper/size.dart';
// import 'package:trivo/helper/styling.dart';


// // ignore: must_be_immutable
// class AdminFulldetails extends StatelessWidget {
//   AdminFulldetails(
//       {super.key,
//       required this.index,
//       required this.image,
//       required this.placeName,
//       required this.location,
//       required this.placedistrict,
//       required this.catogory,
//       required this.description,
//       required this.reach});
//       int index;
//   dynamic image;
//   dynamic placeName;
//   dynamic location;
//   dynamic placedistrict;
//   dynamic catogory;
//   dynamic description;
//   dynamic reach;

//   @override
//   Widget build(BuildContext context) {
//     ValueNotifier<int> _currentpageview =ValueNotifier<int>(0);
//     return Scaffold(

//         appBar: AppBar(),
//         body: Column(
//           children: [
//             SizedBox(
//               height: screenHeight*.30,
//               child: ValueListenableBuilder<List<Destination>>(
//                 valueListenable: destListNotifier,
//                 builder: (context,listdemo, child) {
//                   var data =listdemo[index];
//                   return  PageView.builder(
//                     onPageChanged: (value) {
//                           _currentpageview.value=value;
//                         },
//                         itemCount: data.image.length ,
//                         itemBuilder: 
//                           (BuildContext context,int index){
//                             return  Column(
//                       children: [
//                         Container(
//                           height: screenHeight * .30,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30),
//                             image: DecorationImage(
//                                 fit: BoxFit.cover, image: CachedNetworkImageProvider((image[index]))),
//                           ),
//                           child: const Padding(
//                             padding: EdgeInsets.all(14.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // InkWell(
//                                 //   onTap: () {
//                                 //     Navigator.pop(context);
//                                 //   },
//                                 //   child: const CircleAvatar(
//                                 //     backgroundColor: Color.fromARGB(155, 255, 255, 255),
//                                 //     child: Icon(
//                                 //       Icons.arrow_back,
//                                 //       color: Colors.black,
//                                 //     ),
//                                 //   ),
//                                 // )
//                               ],
//                             ),
//                           ),
//                         ),
                        
//                       ],
//                     );
//                           }
                        
                    
//                   );
//                 },
//               ),
//             ),
//             Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: SingleChildScrollView(
//                       // physics: const AlwaysScrollableScrollPhysics(),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(placeName, style: bold3),
//                             ],
//                           ),
//                           gap,
//                           Padding(
//                             padding: const EdgeInsets.only(top: 0, bottom: 0),
//                             child: Row(
//                               children: [
//                                 Text(location,
//                                     style: const TextStyle(fontSize: 17)),
//                                 const Icon(
//                                   Icons.location_on,
//                                   size: 16,
//                                   color: Color.fromARGB(163, 255, 153, 0),
//                                 ),
//                                 // InkWell(
//                                 //   onTap: () => launchGoogleMaps(map),
//                                 //   child: const Text('(Location)',
                    
//                                 //       style: TextStyle(decoration: TextDecoration.underline,fontSize: 17,color: Colors.blue),),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                           gap,
//                           Text(
//                             catogory,
//                             textAlign: TextAlign.justify,
//                             style: const TextStyle(
//                                 fontSize: 18,
//                                 color: Color.fromARGB(255, 86, 86, 86)),
//                           ),
//                           Text(
//                             description,
//                             textAlign: TextAlign.justify,
//                             style: const TextStyle(
//                                 fontSize: 18,
//                                 color: Color.fromARGB(255, 86, 86, 86)),
//                           ),
//                           Text(
//                             reach,
//                             textAlign: TextAlign.justify,
//                             style: const TextStyle(
//                                 fontSize: 18,
//                                 color: Color.fromARGB(255, 86, 86, 86)),
//                           ),
//                           Text(
//                             placedistrict,
//                             textAlign: TextAlign.justify,
//                             style: const TextStyle(
//                                 fontSize: 18,
//                                 color: Color.fromARGB(255, 86, 86, 86)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//           ],
//         ));
//   }
// }
