import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivo/database/models/fb_model.dart';
import 'package:trivo/favourites/favourites_models.dart';
import 'package:trivo/helper/helper_size.dart';
import 'package:trivo/screens/screen_fulldetails.dart';
import 'package:trivo/database/functions/Firebase/db_manager.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final DataManager dataList = DataManager();

  @override
  Widget build(BuildContext context) {
    final favoriteModel = Provider.of<FavoriteModel>(context);
    favoriteModel.initFavorites(currentUserId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: .2,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Explore',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 2, left: 8, right: 8),
          child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: RefreshIndicator(
              onRefresh: () async {
                await favoriteModel.initFavorites(currentUserId);
                setState(() {});
              },
              child: ValueListenableBuilder<List<DestinationFB>>(
                valueListenable: dataListFromFirebase,
                builder:
                    (BuildContext context, List<DestinationFB> value, child) {
                  var dataEx = value;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 1.4,
                      crossAxisCount: 1,
                      crossAxisSpacing: 12.0,
                      // mainAxisSpacing: 12.0,
                    ),
                    itemCount: dataEx.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = dataEx[index];
                      return InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        data.image[0]),
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
                                      const Color.fromARGB(255, 0, 0, 0)
                                          .withOpacity(0.0),
                                      Colors.black.withOpacity(0.9),
                                    ],
                                    stops: const [0.0, 1.0],
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   top: 10,
                              //   right: 10, 
                              //   child: CircleAvatar(
                              //       radius: 19,
                              //       backgroundColor:
                              //           const Color.fromARGB(76, 94, 94, 94),
                              //       foregroundColor: Colors.black,
                              //       child: IconFavorite(
                              //         destinationId: data.id!,
                              //         size: 23,
                              //       )),
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, bottom: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.placeName,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25,
                                          ),
                                        ),
                                        Text(
                                          data.district,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 231, 231, 231),
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
                                              datas: data,
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
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
