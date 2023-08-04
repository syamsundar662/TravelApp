import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivo/database/functions/Firebase/db_userprofile.dart';
import 'package:trivo/favourites/favourites_models.dart';
import 'package:trivo/screens/screen_explore.dart';
import 'package:trivo/screens/screen_favourites.dart';
import 'package:trivo/screens/screen_home.dart';
import 'package:trivo/screens/screen_searchpage.dart';


class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  ProfileFirebase imgurl = ProfileFirebase();
  int currentindex = 0;
  final _pageViewController = PageController();
  final pages = [
    const HomeScreen(),
    const Searchpage(),
    const Explore(),
    const Favorites(),
  ];

  @override
  void initState() {
    final favoriteModel = Provider.of<FavoriteModel>(context, listen: false);
    favoriteModel.initFavorites(currentUserId);
    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: PageView(
          controller: _pageViewController, // Use the same PageController
          onPageChanged: (value) {
            setState(() {
              currentindex = value;
            });
          },
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          onTap: (value) {
            _pageViewController.animateToPage(
              value,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
            );
            setState(() {
              currentindex = value;
            });
          },
          selectedItemColor: const Color.fromARGB(177, 10, 124, 162),
          unselectedItemColor: const Color.fromARGB(255, 150, 150, 150),
          iconSize: 20,
          currentIndex: currentindex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
              ),
              label: 'Favourites',
            ),
          ],
        ),
      ),
    );
  }
}
