import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:apoorv_app/constants.dart';
import 'package:apoorv_app/screens/homepage/points/points.dart';
import 'package:apoorv_app/widgets/points-widget/transactions.dart';
import 'package:apoorv_app/widgets/points-widget/qr_code.dart';

class PointsTransfer extends StatelessWidget {
  static const routeName = '/points-transfer';
  const PointsTransfer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.yellowColor,
        automaticallyImplyLeading: false,
        title: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(18, 18, 18, 1),
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child:
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search Contacts",
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                )
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        color: Constants.yellowColor,
        child: Column(
          children: [
            Text(
              "1024",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(18, 18, 18, 1),
              ),
            ),
            Text(
              "Points",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Color.fromRGBO(18, 18, 18, 1),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(18, 18, 18, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LAST TRANSACTIONS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                      TransactionsWidget(
                        name: "John Doe",
                        date: "February 29, 2024 at 10:22 AM",
                        points: 54,
                        type: 'credit',
                      ),
                      TransactionsWidget(
                        name: "John Doe",
                        date: "February 29, 2024 at 10:22 AM",
                        points: 23,
                        type: 'debit',
                      ),
                      Constants.gap,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          RichText(
                            text: TextSpan(
                              text: "View More",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {},
                            ),
                          ),
                        ],
                      ),
                      Constants.gap,
                      QrCode(),
                      Constants.gap,
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              PointsScreen.routeName,
                            );
                          },
                          child: Text("View Leaderboard"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Set the desired border radius
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
