import 'package:apoorv_app/providers/user_info_provider.dart';
import 'package:apoorv_app/widgets/signup-flow/logout.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var providerContext = context.read<UserProvider>();
    return Container(
      height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.33 / 2),
                            child: Image.network(
                              providerContext.profilePhotoUrl!,
                              height: MediaQuery.of(context).size.width * 0.33,
                              width: MediaQuery.of(context).size.width * 0.33,
                              fit: BoxFit
                                  .cover, // You might want to add this to cover the entire circular area
                            ),
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
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Apoorv Coins: ${context.read<UserProvider>().points}",
                                      textAlign: TextAlign.center,
                                      // style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                Constants.gap,
                                const LogoutButton(),
                              ],
                            ),
                          )
                        ]),
                    Constants.gap,
                    Text(providerContext.userName,
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
                    Text(providerContext.userEmail,
                        style: const TextStyle(
                            color: Constants.blackColor, fontSize: 16)),
                    const Text("Phone",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Constants.blackColor)),
                    Text(providerContext.userPhNo,
                        style: const TextStyle(
                            color: Constants.blackColor, fontSize: 16)),
                    if (providerContext.fromCollege) ...[
                      const Text('Roll No',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Constants.blackColor)),
                      Text(providerContext.userRollNo!,
                          style: const TextStyle(
                              color: Constants.blackColor, fontSize: 16)),
                    ],
                    const Text('College',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Constants.blackColor)),
                    Text(providerContext.userCollegeName,
                        style: const TextStyle(
                            color: Constants.blackColor, fontSize: 16)),
                    if (!providerContext.fromCollege) ...[
                      const Text('',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Constants.blackColor)),
                      const Text('',
                          style: TextStyle(
                              color: Constants.blackColor, fontSize: 16)),
                    ],
                  ]),
            ),
            Constants.gap,
            Expanded(
              child: Container(
                // width: double.infinity,
                alignment: Alignment.center,
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: Constants.blackColor,
                ),
                child: QrImageView(
                  data: providerContext.uid,
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
