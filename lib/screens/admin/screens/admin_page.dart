import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trivo/database/functions/Hive/db_functions.dart';
import 'package:trivo/database/models/data_model.dart';
// import 'package:trivo/database/models/fb_model.dart';
import 'package:trivo/helper/size.dart';
import 'package:trivo/screens/admin/screens/add_places.dart';

// import 'package:trivo/screens/admin/screens/admin_fulldetails.dart';
// import 'package:trivo/screens/admin/screens/display.dart';
import 'package:trivo/widgets/showdialogue.dart';

late Destination dataObject;
bool isListEmpty = true;

class Adminhome extends StatelessWidget {
  const Adminhome({super.key});

  @override
  Widget build(BuildContext context) {
    getAllDestination();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Admin panel'),
        actions: [
          IconButton(
              onPressed: () {
                signoutadmin(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      // body: ValueListenableBuilder(
      //     valueListenable: destListNotifier,
      //     builder: (BuildContext ctx, List<Destination> destinationList,
      //         Widget? child) {
      //       isListEmpty = destinationList.isEmpty;
      //       return isListEmpty
      //           ? const Center()
      //           : ValueListenableBuilder(
      //               valueListenable: destListNotifier,
      //               builder:
      //                   (context, List<Destination> destinationList, child) {
      //                 return GridView.builder(
      //                     gridDelegate:
      //                         const SliverGridDelegateWithFixedCrossAxisCount(
      //                             childAspectRatio: 3 / 2.7,
      //                             crossAxisCount: 2,
      //                             crossAxisSpacing: 9.0,
      //                             mainAxisSpacing: 9.0),
      //                     itemCount: destinationList.length,
      //                     itemBuilder: (BuildContext context, int index) {
      //                       final data = destinationList[index];
      //                       return Stack(children: [
      //                         Container(
      //                           height: double.infinity,
      //                           width: double.infinity,
      //                           decoration: BoxDecoration(
      //                             color: Colors.white,
      //                             borderRadius: BorderRadius.circular(9),
      //                             boxShadow: const [
      //                               BoxShadow(
      //                                   color:
      //                                       Color.fromARGB(255, 205, 205, 205),
      //                                   blurRadius: 2,
      //                                   spreadRadius: 0,
      //                                   offset: Offset(1, 2),
      //                                   blurStyle: BlurStyle.normal),
      //                             ],
      //                           ),
      //                           child: Padding(
      //                             padding: const EdgeInsets.only(
      //                                 bottom: 17, left: 8, right: 8),
      //                             child: Column(
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.start,
      //                               mainAxisAlignment: MainAxisAlignment.end,
      //                               children: [
      //                                 Row(
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.spaceBetween,
      //                                   children: [
      //                                     Text(
      //                                       data.district,
      //                                       style:
      //                                           const TextStyle(fontSize: 17),
      //                                     ),
      //                                     Row(
      //                                       children: [
      //                                         IconButton(
      //                                             onPressed: () {
      //                                               deleteplace(data);
      //                                             },
      //                                             icon: const Icon(Icons.delete)),
      //                                         InkWell(
      //                                             onTap: () {},
      //                                             child: const Icon(Icons.edit))
      //                                       ],
      //                                     ),
      //                                   ],
      //                                 ),

      //                                 //subline
      //                                 Row(
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.start,
      //                                   children: [
      //                                     const Icon(
      //                                       Icons.location_on,
      //                                       size: 16,
      //                                       color: Color.fromARGB(
      //                                           163, 255, 153, 0),
      //                                     ),
      //                                     Text(
      //                                       data.district,
      //                                       style:
      //                                           const TextStyle(fontSize: 13),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                         Padding(
      //                           padding: const EdgeInsets.all(3.0),
      //                           child: InkWell(
      //                             onTap: () {
      //                               //dataObject=Destination(placeName: data.placeName, location: data.location, district: data.category, category: data.category, description: data.description, reachthere: data.reachthere, image: data.image);
      //                               Navigator.push(
      //                                   context,
      //                                   MaterialPageRoute(
      //                                       builder: (context) =>
      //                                           AdminFulldetails(
      //                                             index:index,
      //                                             image: data.image,
      //                                             placeName: data.placeName,
      //                                             location: data.location,
      //                                             placedistrict: data.district,
      //                                             catogory: data.category,
      //                                             description: data.description,
      //                                             reach: data.reachthere,
      //                                           )
      //                                           )
      //                                           );
      //                             },
      //                             child: Container(
      //                               height: screenHeight * .12,
      //                               width: double.infinity,
      //                               decoration: BoxDecoration(
      //                                   boxShadow: const [
      //                                     BoxShadow(
      //                                       color: Color.fromARGB(
      //                                           255, 205, 205, 205),
      //                                       blurRadius: 7,
      //                                       blurStyle: BlurStyle.normal,
      //                                       spreadRadius: 1,
      //                                       offset: Offset(0, 5),
      //                                     )
      //                                   ],
      //                                   borderRadius: BorderRadius.circular(9),
      //                                   image: DecorationImage(
      //                                       fit: BoxFit.cover,
      //                                       image: FileImage(
      //                                           File(data.image[0])))),
      //                               child: const Align(
      //                                 alignment:  Alignment(0.9, -0.9),
      //                                 // child: Icon(Icons.favorite_border)
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ]);
      //                     });
      //               });
      //     }),
      // // Container(
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Destinations').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final alldoc = snapshot.data!.docs;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 2.7,
                crossAxisCount: 2,
                crossAxisSpacing: 9.0,
                mainAxisSpacing: 9.0,
              ),
              itemCount: alldoc.length,
              itemBuilder: (BuildContext context, int index) {
                final data = alldoc[index];
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
                        padding: const EdgeInsets.only(
                            bottom: 17, left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data['name'],
                                  style: const TextStyle(fontSize: 17),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: const Icon(Icons.edit),
                                    )
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
                                  data['district'],
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
                              image: NetworkImage(data['image'][0]),
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
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
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




// body: ElevatedButton(onPressed: (){
//   void _navigateToDisplayDataPage(List<DestinationFB> data) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => DisplayDataPage(data)),
//   );
// }

// }, child: Text('dis')),