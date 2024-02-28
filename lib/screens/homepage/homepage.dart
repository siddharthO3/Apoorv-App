import 'package:apoorv_app/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int currentPageIndex = 0;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Center(
          child: Text("Drawer"),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Homepage"),
        actions: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.perm_identity));
          }),
        ],
      ),
      body: Container(),
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
