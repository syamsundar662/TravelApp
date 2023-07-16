
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:trivo/helper/size.dart';
// import 'package:trivo/database/models/data_model.dart';
// import 'package:trivo/helper/size.dart';
import 'package:trivo/helper/styling.dart';
import 'package:trivo/lists/trending.dart';
import 'package:trivo/screens/explore.dart';
// import 'package:trivo/screens/fulldetails.dart';
import 'package:trivo/screens/profile.dart';
// import 'package:trivo/widgets/circularLoading.dart';
import 'package:trivo/widgets/home_carousel1.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trivo/widgets/try.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});
   

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<int> containerIndexes =
      List.generate(trending.length, (index) => index);

  final List<int> exploreIndexes = List.generate(6, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //top section (1)
      body: SafeArea(
        
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor ,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 18, right: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>trypage()));
                        },
                        child: const Text(
                          'Discover',
                          style:
                              TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profile())),
                        child: const SizedBox(
                          height: 36,
                          width: 36,
                          child: Icon(
                            Icons.account_circle,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  
                const Text(''),
                //main carousel slider (section 2)
                const CarouselSlidermain(),
                //main carousel slider (section 2)
               
                  
                //section (3)
                  
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Explore more',
                        style: bold2,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Explore()));
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 13),
                            child: Text('See all',style: TextStyle(color: Colors.grey,decoration: TextDecoration.underline,fontSize: 14),),
                          ))
                    ],
                  ),
                ),
                  
                // section (3)
                  
                // section 4(Sub carousel slider)
                // SizedBox(
                //   height: screenHeight * .24,
                //   width: double.infinity,
                //   child: ValueListenableBuilder(
                //     valueListenable: destListNotifier,
                //     builder: (context, List<Destination> listdemo1, child) {
                //       return listdemo1.isEmpty?CircularProgressIndicator(): CarouselSlider(
                //         options: CarouselOptions(
                //           padEnds: false,
                //           height: screenHeight * .22, 
                //           enableInfiniteScroll: false,
                //           viewportFraction: .5,
                //           enlargeCenterPage: false,
                //           autoPlay: false,
                //         ),
                //         items: exploreIndexes.map((index) {
                //           var data = listdemo1[index];
                //           return InkWell(
                //             onTap: () {
                //               Navigator.push(
                //                   context,
                //                  MaterialPageRoute(
                //                               builder: (context) =>
                //                                   DetailsPage(
                //                                     index:index,
                //                                     image: data.image,
                //                                     placeName: data.placeName,
                //                                     location: data.location,
                //                                     placedistrict: data.district,
                //                                     catogory: data.category,
                //                                     description: data.description,
                //                                     reach: data.reachthere,
                //                                   )
                //                                   )
                //               );
                //             },
                //             child: Stack(children: [
                //               Align(
                //                 alignment: const Alignment(0.0, 0.9),
                //                 child: Container(
                //                   margin:
                //                       const EdgeInsets.symmetric(horizontal: 1),
                //                   height: screenHeight * .9,
                //                   width: screenWidth * .415,
                //                   decoration: BoxDecoration(
                //                       boxShadow: const [
                //                         BoxShadow(
                //                             color: Color.fromARGB(
                //                                 255, 205, 205, 205),
                //                             blurRadius: 2,
                //                             spreadRadius: 0,
                //                             offset: Offset(1, 2),
                //                             blurStyle: BlurStyle.normal),
                //                       ],
                //                       color: const Color.fromARGB(
                //                           255, 255, 255, 255),
                //                       borderRadius: BorderRadius.circular(14)),
                //                   //maintitle
                //                   child: Padding(
                //                     padding: const EdgeInsets.all(8.0),
                //                     child: Column(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       mainAxisAlignment: MainAxisAlignment.end,
                //                       children: [
                //                         Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Text(
                //                               data.placeName,
                //                               style:
                //                                   const TextStyle(fontSize: 17),
                //                             ),
                //                             const Icon(
                //                               Icons.arrow_forward_ios_outlined,
                //                               size: 16,
                //                             )
                //                           ],
                //                         ),
                //                         //subline
                //                         Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.start,
                //                           children: [
                //                             // const Icon(
                //                             //   Icons.location_on,
                //                             //   size: 16,
                //                             //   color: Color.fromARGB(
                //                             //       163, 255, 153, 0),
                //                             // ),
                //                             Text('${data.category}',
                //                               style:
                //                                   const TextStyle(fontSize: 13),
                //                             ),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Align(
                //                 alignment: const Alignment(0.0, -0.9),
                //                 child: Container(
                //                   height: screenHeight * .15,
                //                   width: screenWidth * .55,
                //                   margin:
                //                       const EdgeInsets.symmetric(horizontal: 18),
                //                   decoration: BoxDecoration(
                //                     boxShadow: const [
                //                       BoxShadow(
                //                           color:
                //                               Color.fromARGB(255, 205, 205, 205),
                //                           blurRadius: 2,
                //                           spreadRadius: 0,
                //                           offset: Offset(1, 2),
                //                           blurStyle: BlurStyle.normal),
                //                     ],
                //                     borderRadius: BorderRadius.circular(14.0),
                //                     image: DecorationImage(
                //                       image: FileImage(File(data.image[0])),
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ]),
                //           );
                //         }).toList(),
                //       );
                //     },
                //   ),
                // ),\
          
          
          
          
                SizedBox(
                  height: screenHeight * .24,
                  width: double.infinity,
                  child: StreamBuilder(stream: FirebaseFirestore.instance.collection('Destinations').snapshots(), 
                  builder:(context, snapshot) {
                    if(snapshot.hasData){
                     final alldoc = snapshot.data!.docs;
                    return CarouselSlider(
                        options: CarouselOptions(
                          padEnds: false,
                          height: screenHeight * .22, 
                          enableInfiniteScroll: false,
                          viewportFraction: .5,
                          enlargeCenterPage: false,
                          autoPlay: false,
                        ),
                        items: exploreIndexes.map((index) {
                          var data = alldoc[index];
                          return InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //    MaterialPageRoute(
                              //                 builder: (context) =>
                              //                     DetailsPage(
                              //                       index:index,
                              //                       image: data.image,
                              //                       placeName: data.placeName,
                              //                       location: data.location,
                              //                       placedistrict: data.district,
                              //                       catogory: data.category,
                              //                       description: data.description,
                              //                       reach: data.reachthere,
                              //                     )
                              //                     )
                              // );
                            },
                            child: Stack(children: [
                              Align(
                                alignment: const Alignment(0.0, 0.9),
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  height: screenHeight * .9,
                                  width: screenWidth * .415,
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                255, 205, 205, 205),
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                            offset: Offset(1, 2),
                                            blurStyle: BlurStyle.normal),
                                      ],
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(14)),
                                  //maintitle
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data['name'],
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                        //subline
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // const Icon(
                                            //   Icons.location_on,
                                            //   size: 16,
                                            //   color: Color.fromARGB(
                                            //       163, 255, 153, 0),
                                            // ),
                                            Text(data['link'],
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const Alignment(0.0, -0.9),
                                child: Container(
                                  height: screenHeight * .15,
                                  width: screenWidth * .55,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 18),
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 205, 205, 205),
                                          blurRadius: 2,
                                          spreadRadius: 0,
                                          offset: Offset(1, 2),
                                          blurStyle: BlurStyle.normal),
                                    ],
                                    borderRadius: BorderRadius.circular(14.0),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(data['image'][0]),
                                      // image: CachedNetworkImage(imageUrl: data[Image][0]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          );
                        }).toList(),
                      );
   }else if(snapshot.hasError){

    return Text('Error: ${snapshot.error}');
    } else {
      return const Center(child: CircularProgressIndicator());

   } },),
                ),
                // Container(
                //   child: StreamBuilder(stream: FirebaseFirestore.instance.collection('Destinations').snapshots(), 
                //   builder: (context,snapshot){
                //     final alldoc = snapshot.data!.docs;
                //     return GridView.builder(
                //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     childAspectRatio: 3 / 2.7,
                //     crossAxisCount: 2,
                //     crossAxisSpacing: 9.0,
                //     mainAxisSpacing: 9.0),
                //               itemCount: alldoc.length,
                //               itemBuilder: (BuildContext context, int index) {
                //   final data =alldoc[index];
                //   return Stack(children: [
                //     Container(
                //       // height: double.infinity,
                //       // width: double.infinity, 
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(9),
                //         boxShadow: const[
                //           BoxShadow(
                //               color: Color.fromARGB(255, 205, 205, 205),
                //               blurRadius: 2,
                //               spreadRadius: 0,
                //               offset: Offset(1, 2),
                //               blurStyle: BlurStyle.normal),
                //         ],
                //       ),
                //       child:  Padding(
                //                 padding: const EdgeInsets.only(bottom: 17,left: 8,right: 8),
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   mainAxisAlignment: MainAxisAlignment.end,
                //                   children: [
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Text( data['name'],
                //                           style: const TextStyle(fontSize: 17),
                //                         ),
                //                       //  const Icon(
                //                       //     Icons.favorite,
                //                       //     color: Color.fromARGB(190, 231, 50, 37),
                //                       //     size: 19,
                //                       //   )
                //                       ],
                //                     ),
                //                     //subline
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.start,
                //                       children: [
                //                        const Icon(
                //                           Icons.location_on,
                //                           size: 16,
                //                           color:
                //                               Color.fromARGB(163, 255, 153, 0),
                //                         ),
                //                         Text(
                //                           data['link'],
                //                           style: const TextStyle(fontSize: 13),
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.all(3.0),
                //       child: InkWell(
                //         onTap: () {
                          
                //         },
                //         child: Container(
                //           height: screenHeight * .12,
                //           width: double.infinity,
                //           decoration: BoxDecoration(
                //               boxShadow: const [
                //                 BoxShadow(
                //                   color: Color.fromARGB(255, 205, 205, 205),
                //                   blurRadius: 7,
                //                   blurStyle: BlurStyle.normal,
                //                   spreadRadius: 1,
                //                   offset: Offset(0, 5),
                //                 )
                //               ],
                //               borderRadius: BorderRadius.circular(9),
                //               image: DecorationImage(
                //                   fit: BoxFit.cover,
                //                   image: NetworkImage(data['image'][0])
                //                   )
                //                   ),
                //           child: const Align(
                //             alignment:  Alignment(0.9, -0.9),
                //             // child: Icon(Icons.favorite_border)
                //           ),
                //         ),
                //       ),
                //     ),
                //   ]);
                //               });
                //   } 
                //   ),
                // )
          
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
