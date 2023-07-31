import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivo/database/models/fb_model.dart';
import 'package:trivo/favourites/favourites_models.dart';
import 'package:trivo/helper/helper_size.dart';
import 'package:trivo/lists/list_categories.dart';
import 'package:trivo/lists/list_districts.dart';
import 'package:trivo/screens/admin/screens/admin_repo.dart';
import 'package:trivo/screens/screen_searchFullscreen.dart';
import 'package:trivo/widgets/w_filterList.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({
    super.key,
  });

  @override
  State<Searchpage> createState() => _SearchpageState();
}

TextEditingController _searchController = TextEditingController();
List<DestinationFB> searchedlist = [];
bool noitems = false;
bool filtertap = false;
Repository filteredDatas = Repository();

class _SearchpageState extends State<Searchpage> {
  @override
  void initState() {
    super.initState();
    FavoriteModel().favoritesListenable;

    getFiltered();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteModel = Provider.of<FavoriteModel>(context);
    favoriteModel.initFavorites(currentUserId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(136),
        child: SafeArea(
          bottom: false,
          child: AppBar(
            flexibleSpace: Column(
              children: [
                const SizedBox(
                  height: 54,
                ),
                FilterSelecter(
                  list: categories,
                  selectedFilters: selectedFilters,
                ),
                gap,
                FilterSelecter(
                  list: districts,
                  selectedFilters: selectedFilters,
                ),
              ],
            ),
            automaticallyImplyLeading: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            title: CupertinoSearchTextField(
              controller: _searchController,
              onChanged: (value) async {
                await getFiltered();
                setState(() {});
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder<List<DestinationFB>>(
          valueListenable: filtered,
          builder:
              (BuildContext context, List<DestinationFB> value, Widget? child) {
            var dataEx = value.where((destination) {
              return destination.placeName
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase());
            }).toList();

            return dataEx.isEmpty
                ? const Center(child: Text('No result!'))
                : Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await getFiltered();
                        setState(() {});
                      },
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 3 / 1.8,
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                        ),
                        itemCount: dataEx.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = dataEx[index];
                          return InkWell(
                            onTap: () {  
                                Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SearchDetailsPage(datas: data),),);
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 15),
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
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
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
                                          // IconFavorite(
                                          //   destinationId: data.id! ,
                                          //   size: 22,
                                          // )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
