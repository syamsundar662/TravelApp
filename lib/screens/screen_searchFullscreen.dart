import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trivo/database/models/fb_model.dart';
import 'package:trivo/favourites/favourites_icons.dart';
import 'package:trivo/favourites/favourites_models.dart';
import 'package:trivo/helper/helper_size.dart';
import 'package:trivo/helper/helper_styling.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SearchDetailsPage extends StatelessWidget {
  SearchDetailsPage({
    Key? key,
    required this.datas,
  }) : super(key: key);
  DestinationFB datas;
  @override
  Widget build(BuildContext context) {
    final favoriteModel = Provider.of<FavoriteModel>(context);
    favoriteModel.initFavorites(currentUserId);
    List listImg = datas.image;


      double lat = double.parse(datas.latitude ?? '');
      double lon = double.parse(datas.longitude ?? ''); 
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [
              Visibility(
                visible: datas.image
                    .isEmpty, // Show the indicator only if images are not yet loaded
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              Visibility(
                visible: datas.image.isNotEmpty,
                child: SizedBox(
                  height: screenHeight * .45,
                  child: PageView.builder(
                    itemCount: listImg.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Container(
                          height: screenHeight * 0.45,
                          decoration: const BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              // Wrap the CachedNetworkImage with ClipRRect
                              borderRadius: BorderRadius.circular(
                                  20), // Set the desired border radius
                              child: CachedNetworkImage(
                                imageUrl: listImg[index],
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(240, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    datas.placeName,
                                    style: bold3,
                                  ),
                                  gapW5,
                                  Text(
                                    datas.category,
                                    // style: medium,
                                  ),  
                                ],
                              ),
                              IconFavorite(
                                destinationId: datas.id!,
                                size: 25,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'About',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Text(
                            datas.description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 144, 144, 144),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'To reach there!',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Text(
                            datas.reachthere,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 144, 144, 144),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Direction',
                      style: bold2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: GoogleMap(
                              myLocationButtonEnabled: false,
                              myLocationEnabled: false,
                              initialCameraPosition:  CameraPosition(
                                target: LatLng(lat, lon), 
                                zoom: 15,
                              ),
                              markers: {
                                 Marker(
                                  markerId: MarkerId('marker_id'),
                                  position:
                                      LatLng(lat, lon),
                                ),
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: () => launchGoogleMaps(datas.location),
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(195, 0, 0, 0),
                                      borderRadius:
                                          BorderRadius.circular(10)),
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
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17, top: 16),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(126, 255, 255, 255)),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 25,
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}

void launchGoogleMaps(String locationLink) async {
  // ignore: deprecated_member_use
  if (await canLaunch(locationLink)) {
    // ignore: deprecated_member_use
    await launch(locationLink);
  } else {
    throw 'Could not launch $locationLink';
  }
}
