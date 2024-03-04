import 'package:apoorv_app/screens/homepage/homepage.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

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
            const Text(
                "Lorem ipsum dolor sit amet consectetur. A gravida eros aliquam sed condimentum. Etiam vitae sit scelerisque a eget integer. Quis in dolor amet velit pretium sed vestibulum. Urna ullamcorper eu egestas egestas amet id.",
                textAlign: TextAlign.center),
            FilledButton(
              onPressed: () {
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
            ),
          ],
        ),
      ),
    );
  }
}
