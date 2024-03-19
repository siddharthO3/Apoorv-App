import 'package:apoorv_app/api.dart';
import 'package:apoorv_app/widgets/spinning_apoorv.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
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
  Future<Map<String, dynamic>>? _myFuture;
  @override
  void initState() {
    super.initState();
    getLeaderboardUpdates();
  }

  Future<void> getLeaderboardUpdates() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        var s = "";
      },
    );
    setState(() {
      _myFuture =
          APICalls().getLeaderboard(context.read<UserProvider>().idToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _myFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Scaffold(
                body: Center(
                  child: SpinningApoorv(),
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
                    body: CustomMaterialIndicator(
                      indicatorBuilder: (context, controller) =>
                          Image.asset("assets/images/phoenix_74.png"),
                      onRefresh: () => getLeaderboardUpdates(),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: SafeArea(
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
                                      Constants.gradientMid,
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
                                image: data[0]['profileImage'],
                                name: data[0]['fullName'],
                                points: data[0]['points'],
                                uid: data[0]['uid'],
                              )),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                  ),
                                  child: ListView.builder(
                                    itemBuilder: (context, i) =>
                                        LeaderboardCard(
                                      name: data[i + 1]['fullName'],
                                      image: data[i + 1]['profileImage'],
                                      points: data[i + 1]['points'],
                                      rank: i + 2,
                                      uid: data[i + 1]['uid'],
                                    ),
                                    itemCount: data.length - 1,
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(child: Text(snapshot.data['message']));
                }
              } else {
                return const Scaffold(body: Center(child: SpinningApoorv()));
              }
          }
        });
  }
}
