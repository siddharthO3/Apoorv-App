import 'package:flutter/material.dart';

import '../../../widgets/points-widget/leaderboard_card.dart';
import '../points/points.dart';
import 'package:apoorv_app/constants.dart';
import '../../../widgets/points-widget/winner.dart';

class Leaderboard extends StatelessWidget {
  static const routeName = '/leaderboard';
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context){
    String dummy_image='https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg';

    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 1),
      body:
          SafeArea(
            child: SingleChildScrollView(
                child:Column(

                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Constants.yellowColor,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                        )
                      ),
                      padding: const EdgeInsets.all(20.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            child:
                              const Icon(
                                Icons.arrow_back_outlined,
                                size: 30,
                                color: Colors.black,
                              ),
                            onTap: (){
                              Navigator.pop(context);
                            },
                          ),
                          Text("Leaderboard",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Constants.gap,
                          Text("The leaderboard will be displayed till 5pm until the auction starts",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          Text("Please refresh the page to update the leaderboard",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child:
                        Winner(
                          image: dummy_image,
                          name: "John Doe",
                          points: 1000,
                        )
                    ),
                      Column(
                        children: [
                          SizedBox(height: 20,),
                          LeaderboardCard(
                            name: "Mohamed Jaasir",
                            points: 100,
                            rank: 2,
                            image: dummy_image,
                          ),
                          LeaderboardCard(
                            name: "Mohamed Jaasir",
                            points: 100,
                            rank: 3,
                            image: dummy_image,
                          ),
                          LeaderboardCard(
                            name: "Mohamed Jaasir",
                            points: 100,
                            rank: 4,
                            image: dummy_image,
                          ),
                          LeaderboardCard(
                            name: "Siddharth",
                            points: 100,
                            rank: 5,
                            image: dummy_image,
                          ),
                          LeaderboardCard(
                            name: "Mohamed Jaasir",
                            points: 100,
                            rank: 6,
                            image: dummy_image,
                          ),
                        ],
                      ),



                  ],
                ),
            )
          )
    );
  }
}
