import 'package:apoorv_app/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_info_provider.dart';
import '../../../widgets/points-widget/leaderboard_card.dart';
import 'package:apoorv_app/constants.dart';
import '../../../widgets/points-widget/winner.dart';
import '../../../widgets/snackbar.dart';

class Leaderboard extends StatefulWidget {
  static const routeName = '/leaderboard';
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  var _myFuture;
  @override
  void initState() {
    super.initState();
    _myFuture = APICalls().getLeaderboard(context.read<UserProvider>().idToken);
  }

  @override
  Widget build(BuildContext context) {
    String dummyImage =
        'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg';

    return FutureBuilder(
        future: _myFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text(snapshot.error.toString())),
                );
              } else if (snapshot.hasData) {
                // print(snapshot.data);
                if (snapshot.data['success']) {
                  var providerContext = context.read<UserProvider>();

                  var data = snapshot.data['results'] as List;

                  print(data[0]['profileImage']);

                  if (data.length == 1) {
                    Future.delayed(
                        Duration.zero,
                        () => showSnackbarOnScreen(
                            context, "Looks like you are the only one here!"));
                  }
                  if (data[0]['uid'] == providerContext.uid) {
                    Future.delayed(
                        Duration.zero,
                        () => showSnackbarOnScreen(
                            context, "Congrats, you are the top of the board"));
                  }

                  return Scaffold(
                      backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
                      body: SafeArea(
                          child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  Constants.gradientHigh,
                                  Constants.gradientLow
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            padding: const EdgeInsets.all(20.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  child: const Icon(
                                    Icons.arrow_back_outlined,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                const Text(
                                  "Leaderboard",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Constants.gap,
                                const Text(
                                  "The leaderboard will be displayed till 5pm until the auction starts",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  "Please refresh the page to update the leaderboard",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (data.isEmpty)
                            const Center(child: Text("No winner's yet")),
                          Center(
                              child: Winner(
                            image:
                                "https://lh3.googleusercontent.com/a/ACg8ocI98DmbWUvGIcbJv0NzywJ9ONDEqFhmpLTc-Ewv_e83=s96-c",
                            name: data[0]['fullName'],
                            points: data[0]['points'],
                            uid: data[0]['uid'],
                          )),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                              child: ListView.builder(
                                itemBuilder: (context, i) => LeaderboardCard(
                                  name: data[i + 1]['fullName'],
                                  image: data[i + 1]['profileImage'],
                                  points: data[i + 1]['points'],
                                  rank: i + 2,
                                  uid: data[i + 1]['uid'],
                                ),
                                itemCount: data.length - 1,
                              ),
                              // child: ListView(
                              //   // shrinkWrap: true,
                              //   children: [
                              //     const SizedBox(
                              //       height: 20,
                              //     ),
                              //     LeaderboardCard(
                              //       name: "Mohamed Jaasir",
                              //       points: 100,
                              //       rank: 2,
                              //       image: dummyImage,
                              //     ),
                              //     LeaderboardCard(
                              //       name: "Mohamed Jaasir",
                              //       points: 100,
                              //       rank: 3,
                              //       image: dummyImage,
                              //     ),
                              //     LeaderboardCard(
                              //       name: "Mohamed Jaasir",
                              //       points: 100,
                              //       rank: 4,
                              //       image: dummyImage,
                              //     ),
                              //     LeaderboardCard(
                              //       name: "Siddharth",
                              //       points: 100,
                              //       rank: 5,
                              //       image: dummyImage,
                              //     ),
                              //     LeaderboardCard(
                              //       name: "Mohamed Jaasir",
                              //       points: 100,
                              //       rank: 6,
                              //       image: dummyImage,
                              //     ),
                              //     LeaderboardCard(
                              //       name: "Mohamed Jaasir",
                              //       points: 100,
                              //       rank: 7,
                              //       image: dummyImage,
                              //     ),
                              //     LeaderboardCard(
                              //       name: "Mohamed Jaasir",
                              //       points: 100,
                              //       rank: 8,
                              //       image: dummyImage,
                              //     ),
                              //   ],
                              // ),
                              // child: ListView.builder(itemBuilder: (context, index) => LeaderboardCard(),itemCount: ,),
                            ),
                          ),
                        ],
                      )));
                } else {
                  // Future.delayed(
                  //   Duration.zero,
                  //   () =>
                  //       showSnackbarOnScreen(context, snapshot.data['message']),
                  // );
                  return Center(child: Text(snapshot.data['message']));
                }
              } else {
                return const Scaffold(body: Text('No data'));
              }
          }
        });
  }
}
