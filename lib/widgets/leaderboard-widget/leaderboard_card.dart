import 'package:flutter/material.dart';

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
        color=Color.fromARGB(255, 255, 215, 0);
        break;
      case 2:
        color=Color.fromRGBO(255, 192, 192, 192);
        break;
      case 3:
        color=Color.fromARGB(255, 205, 127, 50);
        break;
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10,),
      child:
      Container(
          height: 70,
          width: MediaQuery.of(context).size.width*0.9,
          child:Card(
              color: color ?? Colors.white,
              elevation: 3,
              shadowColor: color ?? Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: color ?? Colors.grey, // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('$rank',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(name!,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text('$points',
                    style: TextStyle(
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
