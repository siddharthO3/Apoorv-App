import 'package:apoorv_app/providers/shopkeeper_provider.dart';
import 'package:apoorv_app/shopkeeper/shopkeeper_signup.dart';
import 'package:apoorv_app/shopkeeper/shopkeeper_welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'widgets/dialog.dart';
import 'widgets/snackbar.dart';
import 'widgets/spinning_apoorv.dart';

class ShopkeeperRouting extends StatefulWidget {
  static const routeName = '/shop-routing';
  const ShopkeeperRouting({super.key});

  @override
  State<ShopkeeperRouting> createState() => _ShopkeeperRoutingState();
}

class _ShopkeeperRoutingState extends State<ShopkeeperRouting> {
  Future<int> getStartupPage(BuildContext context) async {
    Provider.of<ShopkeeperProvider>(context, listen: false);
    if (FirebaseAuth.instance.currentUser == null) {
      return 0;
    }

    print(FirebaseAuth.instance.currentUser);

    try {
      Provider.of<ShopkeeperProvider>(context, listen: false)
          .refreshGoogleServiceData();
      return 1;
    } catch (e) {
      print("Error in the try catch: $e");
      return -1;
    }
  }

  late Future<int> _myFuture;

  @override
  void initState() {
    super.initState();
    _myFuture = getStartupPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _myFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Scaffold(body: Center(child: SpinningApoorv()));

          case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              return Scaffold(
                  body: Center(child: Text(snapshot.error.toString())));
            } else if (snapshot.hasData) {
              // print(snapshot.data);
              var userProgress = snapshot.data;
              if (userProgress == 0) {
                // If no Firebase auth currentuser, then call welcomeScreen()
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context)
                      .pushReplacementNamed(ShopKeeperWelcomeScreen.routeName);
                });
              } else if (userProgress == 1) {
                // If Firebase auth currentuser present, and not in database then call signup screen
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context)
                      .pushReplacementNamed(ShopkeeperSignIn.routeName);
                });
              } else if (userProgress == -1) {
                var message =
                    "There was a connection error! Check your connection and try again";

                Future.delayed(
                    const Duration(seconds: 1),
                    () =>
                        dialogBuilder(context, message: message, function: () {
                          setState(() {
                            _myFuture = getStartupPage(context);
                          });
                          Navigator.of(context).pop();
                        }));

                return const Scaffold(body: Center(child: SpinningApoorv()));
              } else {
                Future.delayed(
                  const Duration(seconds: 0),
                  () => showSnackbarOnScreen(context, "No data on Screen"),
                );
                return const Center(child: Text("No data on Screen"));
              }
            }
            return const Scaffold(body: Center(child: SpinningApoorv()));
        }
      },
    );
  }
}
