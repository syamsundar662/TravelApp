import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trivo/helper/size.dart';
import 'package:trivo/helper/styling.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:trivo/screens/admin/screens/admin_page.dart';
// import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {

  DetailsPage({
    super.key,required this.datas,
    required this.index,
    required this.image,
    required this.placeName,
    required this.location,
    required this.placedistrict,
    required this.catogory,
    required this.description,
    required this.reach,
  });

// List<QueryDocumentSnapshot<DestinationFB>> data;
  int index;
  dynamic image;
  dynamic placeName;
  dynamic location;
  dynamic placedistrict;
  dynamic catogory;
  dynamic description;
  dynamic reach;
  QueryDocumentSnapshot<Object?> datas;
  String? map;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 1,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * .40,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Destinations')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var datas = snapshot.data!.docs;
        
                      return PageView.builder(
                          itemCount: datas.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = datas[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9),
                                  child: Container(
                                    height: screenHeight * .4,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                              data['image'][0])),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  155, 255, 255, 255),
                                              child: Icon(
                                                Icons.arrow_back,
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
        
              // section 2 (Contents)
        
              Expanded(
                child: SingleChildScrollView( 
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //district
                        //  Text(
                        //   placedistrict,
                        //   textAlign: TextAlign.justify,
                        //   style: const TextStyle(
                        //       fontSize: 18,
                        //       color: Color.fromARGB(255, 91, 91, 91)),
                        // ),
                    
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 0, bottom: 0),
                        //   child: Row(
                        //     children: [
                        //       Text(location, style: const TextStyle(fontSize: 17)),
                        //       const Icon(
                        //         Icons.location_on,
                        //         size: 16,
                        //         color: Color.fromARGB(163, 255, 153, 0),
                        //       ),
                        //       InkWell(
                        //         // onTap: () => launchGoogleMaps(map!),
                        //         child: Text(
                        //           location,
                        //           style: TextStyle(
                        //               decoration: TextDecoration.underline,
                        //               fontSize: 17,
                        //               color: Colors.blue),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                    
                        gap,
                    
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(240, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(placeName, style: bold3),
                                        Text(catogory, style: medium),
                    
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.black,
                                        ))
                                  ],
                                ),
                                gap, 
                                const Text(
                                  'About',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal, 
                                      ),
                                ),
                                Text(
                                  description,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 144, 144, 144)),
                                ),
                                const Text(
                                  'More info',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal, 
                                      ),
                                ),
                                Text(
                                 reach,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 144, 144, 144)),
                                ),
                              ],
                            ),
                          ),
                        ),
                       const Padding(
                          padding:  EdgeInsets.all(10),
                          child: Text(
                            'Direction',
                            style: bold2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            child: Stack(children: [
                              SizedBox( 
                                height: 200,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: GoogleMap(
                                        myLocationButtonEnabled: false,
                                        myLocationEnabled: false,
                                        initialCameraPosition: const CameraPosition(
                                          target: LatLng(9.938075160763695,
                                              76.32260743378922), // Default initial location
                                          zoom: 15,
                                        ),
                                        markers: {
                                          const Marker(
                                            markerId: MarkerId('marker_id'),
                                            position: LatLng(9.938075160763695,
                                                76.32260743378922), // Default initial location
                                          ),
                                        },
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 60,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: const Align(
                                        child: Text(
                                      'Get direction',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

// void launchGoogleMaps(String locationLink) async {
//   // ignore: deprecated_member_use
//   if (await canLaunch(locationLink)) {
//     // ignore: deprecated_member_use
//     await launch(locationLink);n
//   } else {
//     throw 'Could not launch $locationLink';
//   }
// }
