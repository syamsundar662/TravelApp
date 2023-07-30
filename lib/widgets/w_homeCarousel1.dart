import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trivo/helper/helper_size.dart';
import 'package:trivo/helper/helper_styling.dart';
import 'package:trivo/screens/admin/screens/db_admin.dart';

class CarouselSlidermain extends StatefulWidget {
  const CarouselSlidermain({Key? key});

  @override
  State<CarouselSlidermain> createState() => _CarouselSlidermainState();
}

class _CarouselSlidermainState extends State<CarouselSlidermain> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * .44,
      width: double.infinity,
          child: CarouselSlider(
            options: CarouselOptions(
              height: screenHeight * .5,
              viewportFraction: .963,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
            ),
                      items: random.value.map((destination) { 
              return Padding(
                padding: const EdgeInsets.only(top: 8 ),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(destination.image[0]), // Use data.image[0] for the image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0.0, 0.92),
                      child: Container(
                        height: screenHeight * .09,
                        width: screenWidth * .90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(162, 255, 255, 255),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10 , top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    destination.placeName,
                                    style: bold2,
                                  ), 
                                  Text(
                                    destination.district,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
}).toList(),
            
    )
        
    );
  }
}
