import 'package:apoorv_app/constants.dart';
import 'package:apoorv_app/screens/profile.dart';
import 'package:flutter/material.dart';

import './points/points.dart';
import './feed/feed.dart';
import './shop/shop.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int currentPageIndex = 0;

class _HomePageState extends State<HomePage> {
  List screens=[
    const FeedScreen(),
    const ShopScreen(),
    const PointsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Constants.yellowColor),
        // automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "APOORV 2K24",
          style: TextStyle(fontSize: 32),
        ),
        leading: Image.asset(
          'assets/images/phoenix_74.png',
          fit: BoxFit.fitHeight,
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: ()=> Navigator.of(context).pushNamed(ProfileScreen.routeName),
              icon: const Icon(Icons.account_circle_outlined),
              iconSize: 32,
              color: Constants.yellowColor,
            );
          }),
        ],
      ),
      body: screens[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Constants.yellowColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.feed_outlined),
            icon: Icon(Icons.feed),
            label: 'Feed',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.store_mall_directory_outlined),
            icon: Icon(Icons.store_mall_directory),
            label: 'Shop',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.stars_outlined),
            icon: Icon(Icons.stars_sharp),
            label: 'Points',
          ),
        ],
      ),
    );
  }
}
