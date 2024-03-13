import 'package:flutter/material.dart';

import '../../../constants.dart';

class LeaderboardCard extends StatelessWidget {
  final String name;
  final String points;
  final String rank;
  final String image;

  const LeaderboardCard({
    super.key,
    required this.name,
    required this.points,
    required this.rank,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    Color? color;
    double? spreadRadius;

    Map<Color, Color> styleColor = {
      Constants.yellowColor: Constants.blackColor,
      Constants.silverColor: Constants.blackColor,
      Constants.redColor: Constants.whiteColor,
    };

    switch ((int.parse(rank) % 2)) {
      case 0:
        color = Constants.yellowColor;
        break;
      case 1:
        color = Constants.silverColor;
        break;
    }

    if (name == 'Siddharth') {
      color = Constants.redColor;
      spreadRadius = 6;
    }
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: color ?? Colors.grey,
                    spreadRadius: spreadRadius ?? 2,
                    // blurRadius: blurRadius ?? 2,
                    offset: const Offset(0, 3),
                  )
                ],
                border: Border.all(
                  color: color ?? Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(10),
                color: color ?? Colors.grey.shade300,
              ),
              child: ListTile(
                  title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        rank,
                        style: TextStyle(
                          fontSize: 20,
                          color: styleColor[color],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(image),
                      ),
                    ],
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      color: styleColor[color],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        points,
                        style: TextStyle(
                          fontSize: 20,
                          color: styleColor[color],
                        ),
                      ),
                      Icon(
                        Icons.stars,
                        color: styleColor[color],
                        size: 20,
                      ),
                    ],
                  )
                ],
              ))),
        ),
      ],
    );
  }
}
