import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trivo/helper/helper_size.dart';
import 'package:trivo/helper/helper_styling.dart';
import 'package:trivo/lists/list_trendingplaces.dart';

class CarouselSlidermain extends StatefulWidget {
  const CarouselSlidermain ({super.key});

  @override
  State<CarouselSlidermain> createState() => _CarouselSlidermainState();
}

class _CarouselSlidermainState extends State<CarouselSlidermain> {
  bool _hasBeenPressed = false;
  final List<int> containerIndexes =
      List.generate(trending.length, (index) => index);
  @override
  Widget build(BuildContext context) {
    return   SizedBox(
                height: screenHeight * .44,
                width: double.infinity,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: screenHeight * .5,
                    viewportFraction: .95,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                  ),
                  items: containerIndexes.map((index) {
                    return InkWell(
                      onTap: () {},
                      child: Stack(children: [
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              image: AssetImage(trending[index][0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0.0, 0.85),
                          child: Container(
                            height: screenHeight * .09,
                            width: screenWidth * .85,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                    const Color.fromARGB(182, 255, 255, 255)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        trending[index][1],
                                        style: bold2,
                                      ),
                                      Text(
                                        trending[index][2],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _hasBeenPressed = !_hasBeenPressed;
                                      });
                                    },
                                    icon: (_hasBeenPressed
                                        ? const Icon(Icons.bookmark_outline)
                                        : const Icon(Icons.bookmark)))
                              ],
                            ),
                          ),
                        ),
                      ]),
                    );
                  }).toList(),
                ),
              );
  }
}