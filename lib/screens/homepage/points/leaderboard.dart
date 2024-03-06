import 'package:flutter/material.dart';

import '../../../widgets/points-widget/leaderboard_card.dart';
import 'package:apoorv_app/constants.dart';
import '../../../widgets/points-widget/winner.dart';

class Leaderboard extends StatelessWidget {
  static const routeName = '/leaderboard';
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    String dummyImage =
        'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg';

    return Scaffold(
        backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    colors: [Constants.gradientHigh, Constants.gradientLow],
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
              Center(
                  child: Winner(
                image: dummyImage,
                name: "John Doe",
                points: 1000,
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.03),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    LeaderboardCard(
                      name: "Mohamed Jaasir",
                      points: 100,
                      rank: 2,
                      image: dummyImage,
                    ),
                    LeaderboardCard(
                      name: "Mohamed Jaasir",
                      points: 100,
                      rank: 3,
                      image: dummyImage,
                    ),
                    LeaderboardCard(
                      name: "Mohamed Jaasir",
                      points: 100,
                      rank: 4,
                      image: dummyImage,
                    ),
                    LeaderboardCard(
                      name: "Siddharth",
                      points: 100,
                      rank: 5,
                      image: dummyImage,
                    ),
                    LeaderboardCard(
                      name: "Mohamed Jaasir",
                      points: 100,
                      rank: 6,
                      image: dummyImage,
                    ),
                    LeaderboardCard(
                      name: "Mohamed Jaasir",
                      points: 100,
                      rank: 7,
                      image: dummyImage,
                    ),
                    LeaderboardCard(
                      name: "Mohamed Jaasir",
                      points: 100,
                      rank: 8,
                      image: dummyImage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
