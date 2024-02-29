import 'package:apoorv_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold(
    //     appBar: AppBar(
    //       titleTextStyle: const TextStyle(color: Constants.yellowColor),
    //       // automaticallyImplyLeading: false,
    //       centerTitle: true,
    //       title: const Text(
    //         "PROFILE",
    //         style: TextStyle(fontSize: 32),
    //       ),
    //       leading: Image.asset(
    //         'assets/images/phoenix_74.png',
    //         fit: BoxFit.fitHeight,
    //       ),
    //     ),
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          // direction: Axis.vertical,
          // spacing: 32,
          children: [
            const Divider(color: Constants.yellowColor),
            SizedBox(
              // width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    spacing: 16,
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      const Text('Siddharth',
                          style: TextStyle(
                              color: Constants.yellowColor, fontSize: 24)),
                      const Text('Roll No.: 2021BCS0054',
                          style: TextStyle(color: Constants.yellowColor)),
                      const Text('Email: siddharth21bcs54@iiit',
                          style: TextStyle(color: Constants.yellowColor)),
                      const Text('Phone: +91 00000 00000',
                          style: TextStyle(color: Constants.yellowColor)),
                      OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Constants.yellowColor),
                                  borderRadius: BorderRadius.circular(8)),
                              foregroundColor: Constants.yellowColor),
                          child: const Text(
                            'Edit',
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 128,
                    color: Constants.yellowColor,
                  ),
                ],
              ),
            ),
            Constants.gap,
            Constants.gap,
            QrImageView(
              data: 'Siddharth',
              backgroundColor: Colors.white,
              size: MediaQuery.of(context).size.width * 0.75,
            ),
          ],
        ),
      ),
    );
  }
}
