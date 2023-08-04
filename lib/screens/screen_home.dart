import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivo/database/functions/Firebase/db_manager.dart';
import 'package:trivo/database/functions/Firebase/db_userprofile.dart';
import 'package:trivo/database/models/fb_model.dart';
import 'package:trivo/helper/helper_size.dart';
import 'package:trivo/helper/helper_styling.dart';
import 'package:trivo/lists/list_categories.dart';
import 'package:trivo/database/functions/Firebase/db_repository.dart';
import 'package:trivo/widgets/w_currentlocation.dart';
import 'package:trivo/screens/screen_fulldetails.dart';
import 'package:trivo/screens/screen_profile.dart';
import 'package:trivo/screens/screen_searchpage.dart';
import 'package:trivo/widgets/w_homecarousel1.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProfileFirebase urlimg = ProfileFirebase();
  bool loadpro = true;

  @override
  void initState() {
    super.initState();
    Repository().getRandomDestinations();
    profileLoad();
  }

  void profileLoad() async {
    setState(() {
      loadpro = true;
      urlimg.imageURLdb;
    });
    await urlimg.getuserimage();
    setState(() {
      loadpro = false;
    });
  }

  DataManager dataManager = DataManager();
  bool catlog = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          actions: [loadpro
                ? const SizedBox(
                    child: Center(
                        child: Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: CupertinoActivityIndicator(),
                  )))
                : IconButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Profile(),
                        ),
                      );
                    },
                    icon: urlimg.imageURLdb != null
                        ? Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: CircleAvatar(
                              radius: 36,
                              backgroundImage: CachedNetworkImageProvider(
                                  urlimg.imageURLdb!),
                            ),
                          )
                        : const Icon(
                            Icons.account_circle,
                            color: Colors.black,
                            size: 34,
                          ),
                  )
          ],
          elevation: .0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Row(
            children: [
              Text(
                'Discover',
                style: TextStyle(
                    fontSize: 37,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ],
          ),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 0,
                ),
                const LocationScreens(),

                //main carousel slider---------start----------- (section 2)
                const CarouselSlidermain(),
                gap,
                //main carousel slide-----------end------------ (section 2)

                //section-------start---------(3)
                const Padding(
                  padding: EdgeInsets.only(
                    left: 9.5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Explore more',
                        style: bold2,
                      ),
                    ],
                  ),
                ),
                gap,
                InkWell(
                  onTap: () async {
                    setState(() {
                      // catlog = true;
                    });
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Searchpage()));
                    setState(() {
                      catlog = false;
                    });
                  },
                  child: SizedBox(
                      height: 39,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 9.5),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: catlog ? Colors.black : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(width: .3)),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(categories[index]),
                              )),
                            ),
                          );
                        },
                      )),
                ),
                gap,
                // section (4)
                SizedBox(
                  height: screenHeight / 2.5,
                  width: screenWidth,
                  child: ValueListenableBuilder<List<DestinationFB>>(
                    valueListenable: dataListFromFirebase,
                    builder: (BuildContext context, List<DestinationFB> value,
                        Widget? child) { var sampleData = value;
                      return Padding(
                        padding: const EdgeInsets.only(left: 9.5, right: 9.5),
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
                              onTap: () {
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
                                          Colors.black.withOpacity(1),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 145,
                                              child: Text(
                                                data.placeName,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
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
                                          padding: EdgeInsets.only(
                                              right: 0, bottom: 8),
                                          child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.white,
                                            size: 18,
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
