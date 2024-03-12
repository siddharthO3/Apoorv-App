import 'package:apoorv_app/screens/homepage/Maps/maps.dart';
import 'package:apoorv_app/screens/homepage/Profile/profile_2.dart';

import '../../constants.dart';
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

  bool popStatus = true;

  @override
  void initState() {
    super.initState();
    popScreen(context);
  }

  Future<void> popScreen(BuildContext context) async {
    popStatus = await Navigator.maybePop(context);
    if (mounted) {
      setState(() {});
    }
  }

  void showAppCloseConfirmation(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text("Do you want to exit? Confirm and click back"),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'Yes',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          setState(() {
            popStatus = true;
          });
        },
      ),
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  List screens = [
    ()=> const FeedScreen(),
    ()=> const MapsScreen(),
    ()=> PointsScreen(stream: st.stream),
    ()=> const Profile2Screen(),
  ];
  @override
  Widget build(BuildContext context) {
    // BaseClient.printAuthTokenForTest();
    return PopScope(
      canPop: popStatus,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        showAppCloseConfirmation(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: screens[currentPageIndex](),
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
      ),
    );
  }
}
