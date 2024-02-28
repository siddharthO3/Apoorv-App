import 'package:flutter/material.dart';

class LeaderboardCard extends StatelessWidget{

  final String? name;
  final String? points;

  const LeaderboardCard({
    super.key,
    this.name,
    this.points,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width*0.9,
      child:Card(
          elevation: 3,
          shadowColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey, // Border color
              width: 2.0, // Border width
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(name!,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(points!,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          )
      )
    );
  }
}