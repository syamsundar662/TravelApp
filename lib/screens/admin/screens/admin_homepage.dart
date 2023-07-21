// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:trivo/database/models/fb_model.dart';
// import 'package:trivo/helper/size.dart';
// import 'package:trivo/screens/admin/screens/add_places.dart';
// import 'package:trivo/screens/admin/screens/db_admin.dart';
// import 'package:trivo/screens/admin/screens/editplace.dart';
// import 'package:trivo/widgets/showdialogue.dart';

// bool isListEmpty = true;

// // ignore: must_be_immutable
// class Adminhome extends StatefulWidget {
//   Adminhome({super.key});

// // Repository destination =Repository();
//   @override
//   State<Adminhome> createState() => _AdminhomeState();
// }

// class _AdminhomeState extends State<Adminhome> {

//   Future<void> editData(DestinationFB destination) async {
//     try {
//       FirebaseFirestore fireStore = FirebaseFirestore.instance;
//       final dest = fireStore.collection('Destinations').doc(destination.id);
//       await dest.update({
//         'name': destination.placeName,
//         'category': destination.category,
//         'description': destination.description,
//         'location': destination.location,
//         'district': destination.district,
//       });
//     } catch (e) {
//       print('---------------------------$e-----------------------');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Admin panel'),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 signoutadmin(context);
//               },
//               icon: Icon(Icons.logout))
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream:
//             FirebaseFirestore.instance.collection('Destinations').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final alldoc = snapshot.data!.docs;
//             return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 childAspectRatio: 3 / 2.7,
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 9.0,
//                 mainAxisSpacing: 9.0,
//               ),
//               itemCount: alldoc.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final data = alldoc[index];
//                 return Stack(
//                   children: [
//                     Container(
//                       height: double.infinity,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(9),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color.fromARGB(255, 205, 205, 205),
//                             blurRadius: 2,
//                             spreadRadius: 0,
//                             offset: Offset(1, 2),
//                             blurStyle: BlurStyle.normal,
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             bottom: 17, left: 8, right: 8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   data['name'],
//                                   style: const TextStyle(fontSize: 17),
//                                 ),
//                                 Row(
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) => EditPlaces(
//                                                 destination: data,
//                                                   // destination:  ,
//                                                   // onEdit: editData
//                                                   )
//                                                   ),
//                                         );
//                                       },
//                                       child: const Icon(Icons.edit),
//                                     ),
//                                     gapW5,
//                                     InkWell(
//                                       onTap: () async {
//                                         await Repository()
//                                             .deleteDoc(data['id']);
//                                       },
//                                       child: const Icon(Icons.delete),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 const Icon(
//                                   Icons.location_on,
//                                   size: 16,
//                                   color: Color.fromARGB(163, 255, 153, 0),
//                                 ),
//                                 Text(
//                                   data['district'],
//                                   style: const TextStyle(fontSize: 13),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(3.0),
//                       child: InkWell(
//                         onTap: () {
//                           // Handle onTap event
//                         },
//                         child: Container(
//                           height: screenHeight * .12,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             boxShadow: const [
//                               BoxShadow(
//                                 color: Color.fromARGB(255, 205, 205, 205),
//                                 blurRadius: 7,
//                                 blurStyle: BlurStyle.normal,
//                                 spreadRadius: 1,
//                                 offset: Offset(0, 5),
//                               )
//                             ],
//                             borderRadius: BorderRadius.circular(9),
//                             image: DecorationImage(
//                               fit: BoxFit.cover,
//                               image:
//                                   CachedNetworkImageProvider(data['image'][0]),
//                             ),
//                           ),
//                           child: const Align(
//                             alignment: Alignment(0.9, -0.9),
//                             // child: Icon(Icons.favorite_border)
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const AddPlaces()));
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// //   void _deleteDestination(dynamic data) async {
// //   bool deleteResult = await deleteDoc(data);
// //   if (deleteResult) {
// //     // Deletion successful, perform any additional actions if needed
// //   } else {
// //     // Deletion failed, handle the error or show an error message
// //   }

// // }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trivo/database/functions/Firebase/db_manager.dart';
import 'package:trivo/database/models/fb_model.dart';
import 'package:trivo/helper/helper_size.dart';
import 'package:trivo/screens/admin/screens/admin_addplaces.dart';
import 'package:trivo/screens/admin/screens/db_admin.dart';
import 'package:trivo/screens/admin/screens/admin_editPlaces.dart';
import 'package:trivo/widgets/w_showdialogue.dart';

bool isListEmpty = true;
class Adminhome extends StatefulWidget {
  const Adminhome({super.key});

  @override
  State<Adminhome> createState() => _AdminhomeState();
}

class _AdminhomeState extends State<Adminhome> {
  DataManager dataManager = DataManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Repository().getalldatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Admin panel'),
        actions: [
          IconButton(
              onPressed: () {
                signoutadmin(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ValueListenableBuilder<List<DestinationFB>>(
        valueListenable: dataListFromFirebase,
        builder:
            (BuildContext context, List<DestinationFB> value, Widget? child) {
          var sampleData = value;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 2.7,
              crossAxisCount: 2,
              crossAxisSpacing: 9.0,
              mainAxisSpacing: 9.0,
            ),
            itemCount: sampleData.length,
            itemBuilder: (BuildContext context, int index) {
              var data = sampleData[index];
              return Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 205, 205, 205),
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: Offset(1, 2),
                          blurStyle: BlurStyle.normal,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 17, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data.placeName,
                                style: const TextStyle(fontSize: 15),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditPlaces(
                                                  destination: data,
                                                  // destination:  ,
                                                  // onEdit: editData
                                                )),
                                      );
                                    },
                                    child: const Icon(Icons.edit),
                                  ),
                                  gapW5,
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          actions:[ 
                                            TextButton(onPressed: (){
                                              Navigator.pop(context); 
                                            },child: const Text('No')),
                                            TextButton( onPressed: () async {
                                                await Repository() 
                                                    .deleteDoc(data.id!); 
                                                Repository().getalldatas(); 
                                                // ignore: avoid_print
                                                print('Deleted');
                                                Navigator.pop(context);
                                              }, 
                                               child: const Text('Yes')),
                                            ],
                                          title : const Text(
                                              'Are you sure you want to delete!'),
                                        ),
                                      );
                                      // await Repository().deleteDoc(data.id!);
                                      // Repository().getalldatas();
                                      // // ignore: avoid_print
                                      // print('Deleted');
                                    },
                                    child: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: Color.fromARGB(163, 255, 153, 0),
                              ),
                              Text(
                                data.district,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: () {
                        // Handle onTap event
                      },
                      child: Container(
                        height: screenHeight * .12,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 205, 205, 205),
                              blurRadius: 7,
                              blurStyle: BlurStyle.normal,
                              spreadRadius: 1,
                              offset: Offset(0, 5),
                            )
                          ],
                          borderRadius: BorderRadius.circular(9),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(data.image[0]),
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment(0.9, -0.9),
                          // child: Icon(Icons.favorite_border)
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPlaces()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
