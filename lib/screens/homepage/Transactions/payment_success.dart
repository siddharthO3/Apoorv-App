import 'package:flutter/material.dart';

import '../../../constants.dart';

class PaymentSuccess extends StatelessWidget {
  static const routeName = '/PaymentSuccess';
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.check_circle,
            size: MediaQuery.of(context).size.width * 0.33,
            color: Constants.yellowColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Constants.yellowColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Constants.blackColor)),
              child: Container(
                height: 48,
                alignment: Alignment.center,
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  child: const Text(
                    'Done',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
