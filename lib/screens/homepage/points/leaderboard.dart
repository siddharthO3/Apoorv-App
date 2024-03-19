import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

import '../../../widgets/points-widget/leaderboard_card.dart';
import 'package:apoorv_app/constants.dart';
import '../../../widgets/points-widget/winner.dart';
import '../../../utils/dummy_data/Leader_board_data.dart';

final List data = ldata;

class Leaderboard extends StatefulWidget {
  static const routeName = '/leaderboard';
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  void initState() {
    super.initState();
    data.sort((b, a) => a.points.compareTo(b.points));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
        body: SafeArea(
            child: CustomMaterialIndicator(
          onRefresh: () async {
            await Future<void>.delayed(const Duration(seconds: 2));
          },
          indicatorBuilder:
              (BuildContext context, IndicatorController controller) {
            return Image.asset(
              "assets/images/BestPhoenix.png",
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
            );
          },
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
                      const Center(
                        child: Text(
                          "Leaderboard",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      final content = data[index];
                      String rnk = '${index + 1}';
                      if (index == 0) {
                        return Center(
                          child: Winner(
                            image: content.dummyImage,
                            name: content.name,
                            points: int.parse(content.points),
                          ),
                        );
                      }
                      return LeaderboardCard(
                        name: content.name,
                        points: content.points,
                        rank: rnk,
                        image: content.dummyImage,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
