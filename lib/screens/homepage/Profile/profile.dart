import 'package:apoorv_app/base_client.dart';
import 'package:apoorv_app/providers/user_info_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  ProfileScreen({super.key});
  String? qrToken;

  void getQRString() async{
    qrToken = await BaseClient.getAuthToken();
  }

  @override
  Widget build(BuildContext context) {
    getQRString();
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
                    Text(context.read<UserProvider>().userName,
                        style: const TextStyle(
                          color: Constants.blackColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                    const Text("Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Constants.blackColor,
                            fontSize: 16)),
                    Text(context.read<UserProvider>().userEmail,
                        style: const TextStyle(
                            color: Constants.blackColor, fontSize: 16)),
                    const Text("Phone",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Constants.blackColor)),
                    Text(context.read<UserProvider>().userPhNo,
                        style: const TextStyle(
                            color: Constants.blackColor, fontSize: 16)),
                    if (context.read<UserProvider>().fromCollege)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Roll No',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Constants.blackColor)),
                          Text(context.read<UserProvider>().userRollNo!,
                              style: const TextStyle(
                                  color: Constants.blackColor, fontSize: 16)),
                        ],
                      ),
                    const Text('College',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Constants.blackColor)),
                    Text(context.read<UserProvider>().userCollegeName!,
                        style: const TextStyle(
                            color: Constants.blackColor, fontSize: 16)),
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
                    data: qrToken!,
                    backgroundColor: Constants.whiteColor,
                    // size: MediaQuery.of(context).size.width * 0.75,
                ) ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
