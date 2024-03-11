import 'package:apoorv_app/screens/signup-flow/welcome.dart';
import 'package:apoorv_app/widgets/provider/shopkeeper_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/provider/user_info_provider.dart';

class ShopkeeperProfileScreen extends StatelessWidget {
  static const routeName = '/shopkeeper-profile';
  const ShopkeeperProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Points Balance: ${context.read<UserProvider>().points}",
                                      textAlign: TextAlign.center,
                                      // style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                Constants.gap,
                                FilledButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        WelcomeScreen.routeName);
                                  },
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
                    const Text("Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Constants.blackColor,
                            fontSize: 16)),
                    Text(context.read<ShopkeeperProvider>().shopkeeperEmail,
                        style: const TextStyle(
                            color: Constants.blackColor, fontSize: 16)),
                    const Text("Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Constants.blackColor)),
                    Text(context.read<ShopkeeperProvider>().shopkeeperPassword,
                        style: const TextStyle(
                            color: Constants.blackColor, fontSize: 16)),

                            // TODO: Plans to add a MAP here and the shop details 
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
