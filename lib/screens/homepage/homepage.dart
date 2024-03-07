import 'package:apoorv_app/screens/homepage/Maps/maps.dart';

import '../../constants.dart';
import 'Profile/profile.dart';
import 'points/points.dart';
import 'package:flutter/material.dart';
import './feed/feed.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  List screens = [
    const FeedScreen(),
    const MapsScreen(),
    const PointsScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   titleTextStyle: const TextStyle(color: Constants.yellowColor),
      //   // automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   title: const Text(
      //     "APOORV 2K24",
      //     style: TextStyle(fontSize: 32),
      //   ),
      //   leading: Image.asset(
      //     'assets/images/phoenix_74.png',
      //     fit: BoxFit.fitHeight,
      //   ),
      // ),
      body: screens[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Constants.redColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.map),
            icon: Icon(Icons.map_outlined),
            label: 'Maps',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.stars),
            icon: Icon(Icons.stars_outlined),
            label: 'Points',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
