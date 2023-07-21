import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trivo/database/models/fb_model.dart';
import 'package:trivo/helper/helper_size.dart';
import 'package:trivo/helper/helper_styling.dart';
import 'package:trivo/lists/list_categories.dart';
import 'package:trivo/lists/list_districts.dart';
import 'package:trivo/screens/admin/screens/db_admin.dart';
import 'package:trivo/widgets/w_filterList.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});


  @override
  State<Searchpage> createState() => _SearchpageState();
}
bool noitems=false;

class _SearchpageState extends State<Searchpage> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFiltered();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(  
          physics: NeverScrollableScrollPhysics(), 
          child: Column( 
            children: [
            const Text('Category',style: bold1 ,), 
            gap,   
            FilterSelecter(list: categories),  
            gap, 
            const Text('District',style: bold1 ,),
            gap,  
            FilterSelecter(list: districts),
            gap,  
                SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),   
                  child: Container(height:screenHeight/1.4,   
                            child: ValueListenableBuilder<List<DestinationFB>>( 
                  valueListenable: filtered  ,
                  builder: (BuildContext context, List<DestinationFB> value,
                      Widget? child) {
                    var dataEx = value;
                    return dataEx.isEmpty? Center(
                      child: const Text('No result!')):
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 3 / 1.8,
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                        ),
                        itemCount: dataEx.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = dataEx[index];
                          return Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(data.image[0]),
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
                                padding: const EdgeInsets.only(left: 15, bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                            color: Color.fromARGB(255, 231, 231, 231),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // IconButton( 
                                    //   onPressed: () {
                                    //     Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) => DetailsPage(
                                    //           datas: data,
                                    //         ),
                                    //       ),
                                    //     );
                                    //   },
                                    //   icon: const Icon(
                                    //     Icons.arrow_forward_ios_outlined,
                                    //     color: Colors.white,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                            ),
                          ),
                )
                
                
            ],
          ),
        ),
      ),
    );
  }
}
