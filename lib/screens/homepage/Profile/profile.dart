import '../../../constants.dart';
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Constants.gradientHigh, Constants.gradientLow],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.account_circle_rounded,
                            size: MediaQuery.of(context).size.width * 0.33,
                            color: Constants.greenColor,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FilledButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Constants.yellowColor),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  ),
                                  child: const SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Points Balance: 100",
                                      textAlign: TextAlign.center,
                                      // style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                Constants.gap,
                                FilledButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Constants.redColor),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Constants.whiteColor),
                                  ),
                                  child: const SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Logout",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                    Constants.gap,
                    const Text('Siddharth Gupta',
                        style: TextStyle(
                          color: Constants.blackColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                    const Text('Roll No',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Constants.blackColor)),
                    const Text('2021BCS0054',
                        style: TextStyle(
                            color: Constants.blackColor, fontSize: 16)),
                    const Text('Email',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Constants.blackColor)),
                    const Text('siddharth21bcs54@iiitkottayam.ac.in',
                        style: TextStyle(
                            color: Constants.blackColor, fontSize: 16)),
                    const Text('Phone',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Constants.blackColor)),
                    const Text('+91 00000 00000',
                        style: TextStyle(
                            color: Constants.blackColor, fontSize: 16)),
                    // const Text('College:',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 16,
                    //         color: Constants.blackColor)),
                    // const Text('IIIT Kottayam',
                    //     style: TextStyle(
                    //         color: Constants.blackColor, fontSize: 16)),
                  ]),
            ),
            Constants.gap,
            Expanded(
              child: Container(
                // width: double.infinity,
                alignment: Alignment.center,
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: Constants.blackColor,
                ),
                child: QrImageView(
                  data: 'Siddharth',
                  backgroundColor: Constants.whiteColor,
                  // size: MediaQuery.of(context).size.width * 0.75,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
