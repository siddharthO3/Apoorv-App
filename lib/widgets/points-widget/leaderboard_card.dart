import 'package:flutter/material.dart';

import 'package:apoorv_app/constants.dart';

class LeaderboardCard extends StatelessWidget{

  final String? name;
  final int? points;
  final int? rank;
  final String? image;

  const LeaderboardCard({
    super.key,
    this.name,
    this.points,
    this.rank,
    this.image,
  });

  @override
  Widget build(BuildContext context){
    Color? color;
    double? spreadRadius;
    double? blurRadius;

    switch((rank!%2)){
      case 0:
        color=Constants.yellowColor;
        break;
      case 1:
        color=Color.fromRGBO(242, 242, 242, 1);
        break;
    }

    if (name == 'Siddharth'){
      color=Constants.redColor;
      spreadRadius=6;
      blurRadius=3;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,),
      child:
      Container(
          height: 70,
          width: MediaQuery.of(context).size.width*0.9,

          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: color ?? Colors.grey,
                spreadRadius: spreadRadius ?? 2,
                blurRadius: blurRadius ?? 2,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('$rank',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 10,),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(image ?? ''),
                      ),
                    ],
                  ),
                  Text(name!,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Text('$points',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.stars,
                        color: Colors.black,
                        size: 20,
                      ),
                    ],
                  )

                ],
              )
          )
      ),
    );

  }
}
