import 'package:flutter/material.dart';

import 'package:apoorv_app/utils/constants.dart';

class LeaderboardCard extends StatelessWidget{

  final String? name;
  final int? points;
  final int? rank;

  const LeaderboardCard({
    super.key,
    this.name,
    this.points,
    this.rank,
  });

  @override
  Widget build(BuildContext context){
    Color? color;
    switch(rank){
      case 1:
        color=Constants.yellowColor;
        break;
      case 2:
        color=Constants.yellowColor;
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,),
      child:
      Container(
          height: 60,
          width: MediaQuery.of(context).size.width*0.9,

          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: color ?? Colors.grey,
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3),
              )
            ],
            border: Border.all(
                color: color ?? Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(5.0),
            color: color ?? Colors.grey.shade300,
          ),
          child:ListTile(

              title:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(name!,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text('$points',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
          )
      ),
    );

  }
}
