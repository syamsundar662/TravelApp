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
  State<Favorites> createState() => FavoritesState();
}

class FavoritesState extends State<Favorites> {
  FavoriteModel fav =FavoriteModel();
   bool _isLoading = true;

  @override
  void initState() {
    // final favoriteModel = Provider.of<FavoriteModel>(context, listen: false);
    // favoriteModel.initFavorites(currentUserId);
    loadFavorites(); 
    super.initState();
    fav.favoritesListenable ;
  }
   loadFavorites() async {
    final favoriteModel = Provider.of<FavoriteModel>(context, listen: false);
    await favoriteModel.initFavorites(currentUserId);
    setState(() {
      _isLoading = false;
    });
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
              _isLoading;
              setState(() {});
            },
            child:_isLoading? const Center( 
                    child: CircularProgressIndicator(),
                  ): ValueListenableBuilder<List<DestinationFB>>(
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
                    : 
                     GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3 / 3,
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 5 ),
                                
                        itemCount: favData.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = favData[index];
                          return 
                          
                           Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Stack(children: [
                              Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(255, 205, 205, 205),
                                        blurRadius: 1 ,
                                        spreadRadius: .5  ,
                                        offset: Offset(0 , 0),
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
                                                const TextStyle(fontSize: 15 ),
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
                                          // const Icon(
                                          //   Icons.location_on,
                                          //   size: 16,
                                          //   color: Color.fromARGB(
                                          //       163, 255, 153, 0),
                                          // ),
                                          Text(
                                            data.district,
                                            style:
                                                const TextStyle(fontSize: 13,color: Colors.grey ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
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
                                        // boxShadow: const [
                                        //   BoxShadow(
                                        //     color: Color.fromARGB(
                                        //         255, 205, 205, 205),
                                        //     blurRadius: 7,
                                        //     blurStyle: BlurStyle.normal,
                                        //     spreadRadius: 1,
                                        //     offset: Offset(0, 5),
                                        //   )
                                        // ],
                                        borderRadius: BorderRadius.circular(13),
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
