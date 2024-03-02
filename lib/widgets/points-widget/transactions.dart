import 'package:flutter/material.dart';

import 'package:apoorv_app/constants.dart';

class TransactionsWidget extends StatelessWidget{
  final String? name;
  final String? date;
  final String? type;
  final int? points;

  const TransactionsWidget({
    super.key,
    this.name,
    this.date,
    this.type,
    this.points,
  });

  @override
  Widget build(BuildContext context){
    String? transactedPoints;
    Color? textColor;
    switch(type){
      case 'credit':
        transactedPoints='+$points';
        textColor=Color.fromRGBO(69, 151, 5,1);
        break;
      case 'debit':
        transactedPoints='- $points';
        textColor=Constants.redColor;
        break;
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child:
      Container(
        decoration: BoxDecoration(
          color: Constants.yellowColor,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(10),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name!,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(18, 18, 18, 1)
                    )
                ),
                Text(date!,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(18, 18, 18, 1)
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(transactedPoints!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                  ),
                ),
                Text("Points",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(18, 18, 18,1),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}