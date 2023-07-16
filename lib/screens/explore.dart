import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trivo/helper/size.dart';
import 'package:trivo/screens/fulldetails.dart';

class Explore extends StatelessWidget {
  const Explore({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Destinations').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final allfiles = snapshot.data!.docs;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3 / 1.4,
                    crossAxisCount: 1,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                  ),
                  itemCount: allfiles.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = allfiles[index];
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(data['image'][0]),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            gradient: LinearGradient(
                              begin: FractionalOffset.center,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                const Color.fromARGB(255, 0, 0, 0).withOpacity(0.0),
                                Colors.black.withOpacity(0.9),
                              ],
                              stops: const [0.0, 1.0],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    data['district'],
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 231, 231, 231),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                        index: index,
                                        image: data['image'][0],
                                        placeName: data['name'],
                                        location: data['link'],
                                        placedistrict: data['district'],
                                        catogory: data['catogory'],
                                        description: data['description'],
                                        reach: data['moreInFo'],
                                        // data: allfiles,
                                        datas: data ,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
} 

// builder: (context, List<Destination> list, child) {
                  // return GridView.builder(
                  //     gridDelegate:
                  //         const SliverGridDelegateWithFixedCrossAxisCount(
                  //             childAspectRatio: 3 / 1.4,
                  //             crossAxisCount: 1,
                  //             crossAxisSpacing: 12.0,
                  //             mainAxisSpacing: 12.0),
                  //     itemCount: list.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       var data = list[index];
                  //       return Stack(children: [
                  //         Container(
                  //           decoration: BoxDecoration(
                  //             image: DecorationImage(
                  //                 fit: BoxFit.cover,
                  //                 image: FileImage(File(data.image[0]))),
                  //             borderRadius: BorderRadius.circular(20),
                  //           ),
                  //         ),
                  //         Container(
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(20),
                  //               color: Colors.white,
                  //               gradient: LinearGradient(
                  //                   begin: FractionalOffset.center,
                  //                   end: FractionalOffset.bottomCenter,
                  //                   colors: [
                  //                     const Color.fromARGB(255, 0, 0, 0)
                  //                         .withOpacity(0.0),
                  //                     Colors.black.withOpacity(0.9),
                  //                   ],
                  //                   stops: const [
                  //                     0.0,
                  //                     1.0
                  //                   ])),
                  //         ),
                  //         Padding(
                  //           padding:
                  //               const EdgeInsets.only(left: 15, bottom: 15),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             crossAxisAlignment: CrossAxisAlignment.end,
                  //             children: [
                  //               Column(
                  //                 mainAxisAlignment: MainAxisAlignment.end,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     data.placeName,
                  //                     style: const TextStyle(
                  //                         color: Colors.white,
                  //                         fontWeight: FontWeight.w500,
                  //                         fontSize: 25),
                  //                   ),
                  //                   Text(
                  //                     data.district,
                  //                     style: const TextStyle(
                  //                         color: Color.fromARGB(
                  //                             255, 231, 231, 231),
                  //                         fontSize: 15),
                  //                   ),
                  //                 ],
                  //               ),
                  //               IconButton(
                  //                   onPressed: () {
                  //                     Navigator.push(
                  //                         context,
                  //                         MaterialPageRoute(
                  //                             builder: (context) => DetailsPage(
                  //                                 index: index,
                  //                                 image: data.image,
                  //                                 placeName: data.placeName,
                  //                                 location: data.location,
                  //                                 placedistrict: data.district,
                  //                                 catogory: data.category,
                  //                                 description: data.description,
                  //                                 reach: data.reachthere)));
                  //                   },
                  //                   icon: const Icon(
                  //                     Icons.arrow_forward_ios_outlined,
                  //                     color: Colors.white,
                  //                   ))
                  //             ],
                  //           ),
                  //         ),
                  //       ]);
                  //     });