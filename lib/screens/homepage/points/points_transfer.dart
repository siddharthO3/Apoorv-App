import 'package:flutter/material.dart';

class PointsTransfer extends StatelessWidget{
  const PointsTransfer({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 1),
      body:
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Center(
                  child:
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child:
                      Column(
                        children: [
                          Icon(
                            Icons.star_border_outlined,
                            size: 50,
                            color: Colors.yellow,
                          ),
                          Text("100",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Text("Available Points",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
          )

    );
  }
}