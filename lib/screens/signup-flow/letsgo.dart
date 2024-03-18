import 'package:apoorv_app/screens/homepage/homepage.dart';
import 'package:apoorv_app/screens/signup-flow/signup.dart';
import 'package:apoorv_app/screens/signup-flow/welcome.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class LetsGoPage extends StatelessWidget {
  static const routeName = "/letsgo";
  const LetsGoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/people_800.png'),
            const Text(
              "Let's Explore The \nApp",
              style: TextStyle(
                  fontSize: 36,
                  color: Constants.yellowColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your one-stop shop for everything Apoorv!\n"
                  "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "-  Earn points by playing games",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "-  Exchange points with friends and climb up the\n "
                  "   leaderboard",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "-  Explore the campus with an interactive virtual\n"
                  "   Map",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "-  Stay updated with the latest Apoorv related\n"
                  "   news and event schedules",
                 style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "\n"
                  "Made with ❤ by team apoorv"
                  "\n",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            FilledButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName(WelcomeScreen.routeName));
                Navigator.of(context).pushNamed(HomePage.routeName);
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Constants.redColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: Container(
                height: 48,
                alignment: Alignment.center,
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
