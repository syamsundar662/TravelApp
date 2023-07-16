import 'package:flutter/material.dart';
import 'package:trivo/screens/explore.dart';
import 'package:trivo/screens/favourites.dart';
import 'package:trivo/screens/home_screen.dart';
import 'package:trivo/screens/search_page.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final _pageViewController = PageController();
  int currentindex = 0;
  final _pages = [HomeScreen(), Searchpage(), Favorites(), Explore()];
  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          // backgroundColor: Colors.white ,
          body: _pages[currentindex],
          bottomNavigationBar: BottomNavigationBar(
            // backgroundColor:Color.fromARGB(255, 255, 255, 255),
            elevation: 0,
            onTap: (value) {
              setState(() {
                currentindex = value;
              });
            },

            selectedItemColor: Color.fromARGB(255, 0, 0, 0),
            unselectedItemColor: const Color.fromARGB(255, 150, 150, 150),
            iconSize: 22,
            type: BottomNavigationBarType.fixed,

            currentIndex: currentindex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline), label: 'Favourites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore_outlined), label: 'Explore'),
            ],
          ),
        ),
      ),
    );
  }
}
