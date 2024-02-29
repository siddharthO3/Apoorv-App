import 'package:flutter/material.dart';

import 'package:apoorv_app/widgets/score-card/score_card.dart';
import 'package:apoorv_app/widgets/leaderboard-widget/leaderboard_card.dart';

class PointsScreen extends StatelessWidget {
  static const routeName = '/points';
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ScoreCard(
                icon: Icons.monetization_on,
                value: '100',
              ),
              ScoreCard(
                icon: Icons.star_outline_rounded,
                value: '100',
              )
            ],
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Leaderboard",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                LeaderboardCard(
                  name: "Mohamed Jaasir",
                  points: 100,
                  rank: 1,
                ),
                LeaderboardCard(
                  name: "Mohamed Jaasir",
                  points: 100,
                  rank: 2,
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 6.0,
                ),
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 4.0,
                ),
              ],
            ),
          ),
          Center(
            child: LeaderboardCard(
              name: "Mohamed Jaasir",
              points: 100,
              rank: 7,
            ),
          ),
        ],
      ),
    ));
  }
}
