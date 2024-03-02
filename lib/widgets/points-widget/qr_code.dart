import 'package:flutter/material.dart';

import 'package:apoorv_app/constants.dart';

class QrCode extends StatelessWidget{
  const QrCode({super.key});

  @override
  Widget build(BuildContext context){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap:null,
            child:
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Constants.yellowColor,
                ),
                child:
                  const Column(
                    children: [
                      Icon(
                        Icons.qr_code,
                        size: 30,
                        color: Color.fromRGBO(18, 18, 18, 1),
                      ),
                      Text("Show",
                        style: TextStyle(
                          color: Color.fromRGBO(18, 18, 18, 1),
                        ),
                      ),
                      Text("QR CODE",
                        style: TextStyle(
                          color: Color.fromRGBO(18, 18, 18, 1),
                        ),
                      ),
                    ],
                  )
              ),
          ),

          GestureDetector(
            onTap: null,
            child:
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Constants.yellowColor,
                ),
                child:
                  const Column(
                    children: [
                      Icon(
                        Icons.qr_code_scanner_sharp,
                        size: 30,
                        color: Color.fromRGBO(18, 18, 18, 1),
                      ),
                      Text("Scan",
                        style: TextStyle(
                          color: Color.fromRGBO(18, 18, 18, 1),
                        ),
                      ),
                      Text("QR CODE",
                        style: TextStyle(
                          color: Color.fromRGBO(18, 18, 18, 1),
                        ),
                      ),
                    ],
                )
            ),
          )
        ],
      );
  }
}