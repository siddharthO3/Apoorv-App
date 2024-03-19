import 'api.dart';
import 'providers/user_info_provider.dart';
import 'screens/homepage/homepage.dart';
import 'screens/signup-flow/signup.dart';
import 'screens/signup-flow/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'widgets/snackbar.dart';
import 'widgets/spinning_apoorv.dart';

class Routing extends StatefulWidget {
  static const routeName = '/routing';
  const Routing({super.key});

  @override
  State<Routing> createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {
  Future<int> getStartupPage(BuildContext context) async {
    Provider.of<UserProvider>(context, listen: false);

    if (FirebaseAuth.instance.currentUser == null) {
      return 0;
    }

    var usrResponse = await APICalls().getUserDataAPI(
      FirebaseAuth.instance.currentUser!.uid,
      (await FirebaseAuth.instance.currentUser!.getIdToken())!,
    );

    // print(FirebaseAuth.instance.currentUser!);
    // BaseClient.printAuthTokenForTest();

    // userProvider.refreshIdToken();
    // print(context.read<UserProvider>().idToken);
    // print("In here");
    // var usrResponse = await userProvider.getUserInfo();

    if (!usrResponse['success']) {
      return 1;
    } else if (usrResponse['success']) {
      // print(context.read<UserProvider>().);
      var prov = Provider.of<UserProvider>(context, listen: false);
      if (usrResponse['fromCollege']) {
        prov.changeSameCollegeDetails(
          newUserName: usrResponse['fullName'],
          newUserRollNo: usrResponse['rollNumber'],
          newUserPhNo: usrResponse['phone'],
        );

        // prov.updateProfilePhoto(usrResponse['photoUrl']);
        // prov.updatePoints(usrResponse['points']);
        // prov.updateEmail(usrResponse['email']);
        // prov.refreshUID();
        // prov.refreshIdToken();
      } else {
        prov.changeOtherCollegeDetails(
          newUserName: usrResponse['fullName'],
          newUserCollegeName: usrResponse['collegeName'],
          newUserPhNo: usrResponse['phone'],
        );
      }
      prov.updateProfilePhoto(usrResponse['photoUrl']);
      prov.updatePoints(usrResponse['points']);
      prov.updateEmail(usrResponse['email']);
      prov.refreshUID();
      prov.refreshIdToken();

      return 2;
    }

    return -1;
  }

  late Future<int> _myFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     // Update idToken after the first frame is built
  //     Provider.of<UserProvider>(context, listen: false).refreshIdToken();
  //     setState(() {
  //       _myFuture = getStartupPage(context);
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _myFuture = getStartupPage(context);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Update idToken after the first frame is built
    //   Provider.of<UserProvider>(context, listen: false).refreshIdToken();
    //   _myFuture = getStartupPage(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _myFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Scaffold(
                body: Center(child: SpinningApoorv()));

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
                      .pushReplacementNamed(WelcomeScreen.routeName);
                });
              } else if (userProgress == 1) {
                // If Firebase auth currentuser present, and not in database then call signup screen
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context)
                      .pushReplacementNamed(SignUpScreen.routeName);
                });
              } else if (userProgress == 2) {
                // If firebase auth currentuser present, and in database then call homepage
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context)
                      .pushReplacementNamed(HomePage.routeName);
                });
              } else {
                Future.delayed(
                  const Duration(seconds: 0),
                  () => showSnackbarOnScreen(context, "No data on Screen"),
                );
                return const Center(child: Text("No data on Screen"));
              }
            }
            // else {
            return const Scaffold(body: Text('No data'));
          // }
        }
      },
    );
  }
}
