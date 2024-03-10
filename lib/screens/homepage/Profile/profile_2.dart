import 'dart:async';

import 'package:apoorv_app/providers/user_info_provider.dart';
import 'package:apoorv_app/screens/homepage/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../constants.dart';
import '../../../widgets/signup-flow/logout.dart';
import '../../../widgets/snackbar.dart';

class Profile2Screen extends StatefulWidget {
  static const routeName = '/profile-2';
  const Profile2Screen({super.key});

  @override
  State<Profile2Screen> createState() => _Profile2ScreenState();
}

class _Profile2ScreenState extends State<Profile2Screen> {
  var _myFuture;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _updateProfileData(); // Call the function to initially fetch and update profile data
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _updateProfileData(); // Call the function to fetch and update profile data every 10 seconds
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  // Function to fetch and update profile data
  Future<void> _updateProfileData() async {
    setState(() {
      _myFuture =
          Provider.of<UserProvider>(context, listen: false).getUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _myFuture,
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const ProfileScreen();

            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text(snapshot.error.toString())),
                );
              } else if (snapshot.hasData) {
                print(snapshot.data);
                if (snapshot.data['success']) {
                  Provider.of<UserProvider>(ctx);
                  var providerContext = ctx.read<UserProvider>();
                  // providerContext.refreshUID();

                  var data = snapshot.data;

                  Future.delayed(Duration.zero,
                      () => showSnackbarOnScreen(ctx, data['message']));

                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Constants.gradientHigh, Constants.gradientLow],
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(ctx).size.width * 0.05),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.33 /
                                                  2),
                                          child: Image.network(
                                            providerContext.profilePhotoUrl!,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.33,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.33,
                                            fit: BoxFit
                                                .cover, // You might want to add this to cover the entire circular area
                                          ),
                                        ),

                                        // Icon(
                                        //   Icons.account_circle_rounded,
                                        //   size: MediaQuery.of(ctx).size.width *
                                        //       0.33,
                                        //   color: Constants.greenColor,
                                        // ),
                                        SizedBox(
                                          width: MediaQuery.of(ctx).size.width *
                                              0.45,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              FilledButton(
                                                onPressed: () {},
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty
                                                          .all<Color>(Constants
                                                              .yellowColor),
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.black),
                                                ),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    "Points Balance: ${providerContext.points}",
                                                    textAlign: TextAlign.center,
                                                    // style: TextStyle(fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                              Constants.gap,
                                              const LogoutButton(),
                                            ],
                                          ),
                                        )
                                      ]),
                                  Constants.gap,
                                  Text(providerContext.userName,
                                      style: const TextStyle(
                                        color: Constants.blackColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const Text("Email",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Constants.blackColor,
                                          fontSize: 16)),
                                  Text(providerContext.userEmail,
                                      style: const TextStyle(
                                          color: Constants.blackColor,
                                          fontSize: 16)),
                                  const Text("Phone",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Constants.blackColor)),
                                  Text(providerContext.userPhNo,
                                      style: const TextStyle(
                                          color: Constants.blackColor,
                                          fontSize: 16)),
                                  if (providerContext.fromCollege)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Roll No',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Constants.blackColor)),
                                        Text(providerContext.userRollNo!,
                                            style: const TextStyle(
                                                color: Constants.blackColor,
                                                fontSize: 16)),
                                      ],
                                    ),
                                  const Text('College',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Constants.blackColor)),
                                  Text(providerContext.userCollegeName!,
                                      style: const TextStyle(
                                          color: Constants.blackColor,
                                          fontSize: 16)),
                                  if (!providerContext.fromCollege)
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Constants.blackColor)),
                                        Text('',
                                            style: TextStyle(
                                                color: Constants.blackColor,
                                                fontSize: 16)),
                                      ],
                                    ),
                                ]),
                          ),
                          Constants.gap,
                          Expanded(
                            child: Container(
                              // width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(
                                  MediaQuery.of(ctx).size.width * 0.05),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                                color: Constants.blackColor,
                              ),
                              child: QrImageView(
                                data: providerContext.uid,
                                backgroundColor: Constants.whiteColor,
                                // size: MediaQuery.of(context).size.width * 0.75,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  Future.delayed(
                    Duration.zero,
                    () =>
                        showSnackbarOnScreen(context, snapshot.data['message']),
                  );
                  return Center(child: Text(snapshot.data['message']));
                }
              } else {
                return const Scaffold(body: Text('No data'));
              }
          }
        });
  }
}
