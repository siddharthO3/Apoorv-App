import 'package:apoorv_app/screens/homepage/Transactions/payment_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../constants.dart';

Future<void> dialogBuilder(BuildContext context, {String? dialog, Function? onFailedPayment}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Payment Failed',
          style: TextStyle(
            color: Constants.blackColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Constants.yellowColor,
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: Theme.of(context).textTheme.labelLarge,
                backgroundColor: Constants.blackColor),
            child: const Text(
              'Try Again',
              style: TextStyle(color: Constants.whiteColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class Payment extends StatelessWidget {
  static const routeName = '/Payment';
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const IconButton(onPressed: null, icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.circle,
              size: MediaQuery.of(context).size.width * 0.33,
              color: Constants.yellowColor,
            ),
            const Column(
              children: [
                Text(
                  "Paying John Doe",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "johndoe@gmail.com",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            SizedBox(
              width: 178,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 120,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                      style: const TextStyle(fontSize: 50),
                    ),
                  ),
                  const Text(
                    "pts",
                    style: TextStyle(fontSize: 35),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 120,
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Add Note'),
              ),
            ),
            OutlinedButton(
                onPressed: () => dialogBuilder(context),
                child: const Text('If Failed')),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(PaymentSuccess.routeName);
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Constants.redColor),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Constants.whiteColor)),
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
            ),
          ],
        ),
      ),
    );
  }
}
