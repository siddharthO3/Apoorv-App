import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/points-widget/transactions.dart';
import '../../widgets/provider/user_info_provider.dart';
import '../../widgets/signup-flow/qr/scan_qr.dart';

class ShopkeeperPointsScreen extends StatelessWidget {
  static const routeName = '/shopkeeper-points';
  const ShopkeeperPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Constants.gradientHigh, Constants.gradientLow],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      // color: Constants.yellowColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Constants.gap,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  context.read<UserProvider>().points.toString(),
                  style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.w700,
                    color: Constants.blackColor,
                  ),
                ),
                const Text(
                  "Shop Points",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 36,
                    color: Constants.blackColor,
                  ),
                ),
                Constants.gap,
              ],
            ),
            // Constants.gap,
            // Expanded(
            //   child: SingleChildScrollView(
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Constants.blackColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  child: const Column(
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
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'View More',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Constants.gap,
                      // QrCode(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [ScanQR()],
                      ),

                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // ),
          ],
        ),
      ),
      // ),
    );
  }
}
