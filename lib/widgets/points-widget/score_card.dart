import 'package:flutter/material.dart';

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
    return SizedBox(
      width: 120,
      height: 120,
      child:
          Card(
            elevation: 5,
            color: Colors.black,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(9.0),
            ),
            child:
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Icon(
                      icon!,
                      color: Colors.yellow,
                      size: 40,
                    ),
                  ),

                  Text(value!,
                    style: const TextStyle(
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