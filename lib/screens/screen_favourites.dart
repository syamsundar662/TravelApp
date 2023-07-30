import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivo/database/models/fb_model.dart';
import 'package:trivo/favourites/favourites_icons.dart';
import 'package:trivo/favourites/favourites_models.dart';
import 'package:trivo/helper/helper_size.dart';
import 'package:trivo/screens/screen_fulldetails.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    final favoriteModel = Provider.of<FavoriteModel>(context, listen: false);
    favoriteModel.initFavorites(currentUserId);
    super.initState();
    FavoriteModel().favoritesListenable;
  }

  @override
  Widget build(BuildContext context) {
    final favoriteModel = Provider.of<FavoriteModel>(context);
    FavoriteModel().initFavorites(currentUserId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: .2,
          automaticallyImplyLeading: false,
          title: const Text(
            'Favourites',
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
          padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
          child: RefreshIndicator(
            onRefresh: () async {
              await favoriteModel.initFavorites(currentUserId);
              setState(() {});
            },
            child: ValueListenableBuilder<List<DestinationFB>>(
              valueListenable: favoriteModel.favoritesListenable,
              builder:
                  (BuildContext context, List<DestinationFB> value, child) {
                var favData = value;
                return favData.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No favourites  ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'You can add an item to your favourites by clicking Favourite icon',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 110, 110, 110)),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3 / 2.8,
                                crossAxisCount: 2,
                                crossAxisSpacing: 9.0,
                                mainAxisSpacing: 3),
                        itemCount: favData.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = favData[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Stack(children: [
                              Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(9),
                                  boxShadow: const [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(255, 205, 205, 205),
                                        blurRadius: 2,
                                        spreadRadius: 0,
                                        offset: Offset(1, 2),
                                        blurStyle: BlurStyle.normal),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 12, left: 8, right: 8),
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
                                            data.placeName,
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                          IconFavorite(
                                            destinationId: data.id!,
                                            size: 22,
                                          )
                                        ],
                                      ),
                                      //subline
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            size: 16,
                                            color: Color.fromARGB(
                                                163, 255, 153, 0),
                                          ),
                                          Text(
                                            data.district,
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsPage(datas: data))),
                                  child: Container(
                                    height: screenHeight * .12,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 205, 205, 205),
                                            blurRadius: 7,
                                            blurStyle: BlurStyle.normal,
                                            spreadRadius: 1,
                                            offset: Offset(0, 5),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(9),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                                data.image[0]))),
                                    child: const Align(
                                      alignment: Alignment(0.9, -0.9),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          );
                        });
              },
            ),
          ),
        ),
      ),
    );
  }
}
