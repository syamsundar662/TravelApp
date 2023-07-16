import 'package:flutter/material.dart';
import 'package:trivo/helper/size.dart';
import 'package:trivo/lists/explore1.dart';
import 'package:trivo/lists/trending.dart';


class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
        
          backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
          elevation: 0,
        automaticallyImplyLeading: false,
          title: const Text('Favourites',style: TextStyle(color: Colors.black,fontSize: 25),),
          ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 2.7,
                  crossAxisCount: 2,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0),
              itemCount: trending.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity, 
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: const[
                        BoxShadow(
                            color: Color.fromARGB(255, 205, 205, 205),
                            blurRadius: 2,
                            spreadRadius: 0,
                            offset: Offset(1, 2),
                            blurStyle: BlurStyle.normal),
                      ],
                    ),
                    child:  Padding(
                              padding: const EdgeInsets.only(bottom: 17,left: 8,right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ' ${explore1[index][1]}',
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                     const Icon(
                                        Icons.favorite,
                                        color: Color.fromARGB(190, 231, 50, 37),
                                        size: 19,
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
                                        color:
                                            Color.fromARGB(163, 255, 153, 0),
                                      ),
                                      Text(
                                        '${explore1[index][2]}',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: () {

                      },
                      child: Container(
                        height: screenHeight * .12,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 205, 205, 205),
                                blurRadius: 7,
                                blurStyle: BlurStyle.normal,
                                spreadRadius: 1,
                                offset: Offset(0, 5),
                              )
                            ],
                            borderRadius: BorderRadius.circular(9),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(trending[index][0]))),
                        child: const Align(
                          alignment:  Alignment(0.9, -0.9),
                          // child: Icon(Icons.favorite_border)
                        ),
                      ),
                    ),
                  ),
                ]);
              }),
        ),
      ),
    );
  }
}
