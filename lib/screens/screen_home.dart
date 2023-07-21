import 'package:flutter/material.dart';
import 'package:trivo/database/functions/Firebase/db_manager.dart';
import 'package:trivo/database/models/fb_model.dart';
import 'package:trivo/helper/helper_size.dart';
import 'package:trivo/helper/helper_styling.dart';
import 'package:trivo/screens/screen_explore.dart';
import 'package:trivo/screens/screen_fulldetails.dart';
import 'package:trivo/screens/screen_profile.dart';
import 'package:trivo/widgets/w_homeCarousel1.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false ,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Profile())),
            child: const Icon(
              Icons.account_circle,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),],
        centerTitle: true,
        title: const Text(
              'Discover', 
              style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            
        
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 0, left: 18, right: 13),
                ),

                //main carousel slider---------start----------- (section 2)
                const CarouselSlidermain(), 
                 //main carousel slide-----------end------------ (section 2)

                //section-------start---------(3)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
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
                                    builder: (context) => Explore()));
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 10, top: 5),
                            child: Text(
                              'See all',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 95, 94, 94),
                                  decoration: TextDecoration.underline,
                                  fontSize: 12),
                            ),
                          ))
                    ],
                  ),
                ),
                // section (4)
                SizedBox(
                  height: screenHeight / 3,
                  width: screenWidth,
                  child: ValueListenableBuilder<List<DestinationFB>>(
                    valueListenable: dataListFromFirebase,
                    builder: (BuildContext context, List<DestinationFB> value,
                        Widget? child) {
                      // if (value.isEmpty) {
                      //   return CircularProgressIndicator();
                      // }
                      var sampleData = value;
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2 / 1.5,
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                          ),
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            var data = sampleData[index];
                            return InkWell(
                              onTap: (){
                                 Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                datas: data,
                                              ),
                                            ),
                                          ); 
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            data.image[0]),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      gradient: LinearGradient(
                                        begin: FractionalOffset.center,
                                        end: FractionalOffset.bottomCenter,
                                        colors: [
                                          const Color.fromARGB(255, 0, 0, 0)
                                              .withOpacity(0.0),
                                          Colors.black.withOpacity(1 ),
                                        ],
                                        stops: const [0.0, 1.3],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.placeName,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize:16, 
                                              ),
                                            ),
                                            Text(
                                              data.district,
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 231, 231, 231),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                       const Padding(
                                         padding: EdgeInsets.only(right: 0 ,bottom: 8 ),
                                         child: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.white,size: 18,
                                            ),
                                       ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
