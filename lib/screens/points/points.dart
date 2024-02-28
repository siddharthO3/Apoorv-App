import 'package:flutter/material.dart';

import 'package:apoorv_app/widgets/score-card/score_card.dart';
import 'package:apoorv_app/widgets/leaderboard-widget/leaderboard_card.dart';

class PointsScreen extends StatelessWidget{
  static const routeName = '/points';
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 1),
      body:
          SafeArea(
            child: SingleChildScrollView(
                child:Column(
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
                    SizedBox(height: 40,),
                    Text(
                      "Leaderboard",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20,),
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
                    LeaderboardCard(
                      name: "Mohamed Jaasir",
                      points: 100,
                      rank: 3,
                    ),
                    LeaderboardCard(
                      name: "Mohamed Jaasir",
                      points: 100,
                      rank: 4,
                    ),
                    LeaderboardCard(
                      name: "Mohamed Jaasir",
                      points: 100,
                      rank: 5,
                    ),
                    LeaderboardCard(
                      name: "Mohamed Jaasir",
                      points: 100,
                      rank: 6,
                    ),
                    LeaderboardCard(
                      name: "Mohamed Jaasir",
                      points: 100,
                      rank: 7,
                    ),
                  ],
                ),
            )
          )
    );
  }
}