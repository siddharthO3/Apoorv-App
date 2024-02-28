import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ScoreCard extends StatelessWidget{

  final IconData? icon;
  final String? value;

  const ScoreCard({
    super.key,
    this.icon,
    this.value,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      width: 120,
      height: 120,
      child:
          Card(
            elevation: 5,
            color: Colors.black,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(9.0),
            ),
            child:
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Icon(
                      icon!,
                      color: Colors.yellow,
                      size: 40,
                    ),
                  ),

                  Text(value!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            )

    );
  }
}