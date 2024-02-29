import 'package:apoorv_app/constants.dart';
import 'package:apoorv_app/screens/homepage/homepage.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/sign-up-1';
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: RichText(
            text: const TextSpan(
              children: [
                TextSpan(text: 'Stage '),
                TextSpan(
                    text: ' 1', style: TextStyle(color: Constants.redColor)),
                TextSpan(text: ' of 3'),
              ],
              style: TextStyle(fontSize: 24),
            ),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Give us a Quick Introduction\n',
                        style: TextStyle(color: Constants.redColor)),
                    TextSpan(
                        text: 'About ',
                        style: TextStyle(color: Constants.redColor)),
                    TextSpan(
                        text: 'Yourself',
                        style: TextStyle(color: Constants.yellowColor)),
                  ],
                  style:
                      TextStyle(fontFamily: 'Libre Baskerville', fontSize: 22),
                ),
                textAlign: TextAlign.center,
              ),
              Icon(
                Icons.account_circle_outlined,
                color: Constants.yellowColor,
                size: MediaQuery.of(context).size.width * 0.4,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                      decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    filled: true,
                    fillColor: Constants.yellowColor,
                    hintText: 'Full Name',
                    hintStyle: const TextStyle(color: Colors.black),
                  )),
                  Constants.gap,
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        filled: true,
                        fillColor: Constants.yellowColor,
                        label: const Text('Roll Number',
                            style: TextStyle(color: Colors.black))),
                  ),
                  Constants.gap,
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        filled: true,
                        fillColor: Constants.yellowColor,
                        label: const Text('Email',
                            style: TextStyle(color: Colors.black))),
                  ),
                ],
              )),
              FilledButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(HomePage.routeName),
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
              )
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
