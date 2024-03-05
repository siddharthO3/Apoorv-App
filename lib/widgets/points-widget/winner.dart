import 'package:flutter/material.dart';

import '../../constants.dart';

class Winner extends StatelessWidget{
  final String? image;
  final String? name;
  final int? points;

  const Winner({
    super.key,
    this.image,
    this.name,
    this.points,
  });

  @override
  Widget build(BuildContext context){

    return Column(
      children: [
        CircleAvatar(
            backgroundImage: NetworkImage(image ?? ''),
            radius: 50,
            child:
            Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.emoji_events, color: Constants.redColor, size: 40,),
                )
              ],
            )
        ),
        Text(name!,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$points",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.stars,
              color: Colors.white,
              size: 16,
            )
          ],
        )
      ],
    );
  }
}