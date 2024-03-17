import 'package:apoorv_app/providers/receiver_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../points/points.dart';

class PaymentSuccess extends StatefulWidget {
  static const routeName = '/PaymentSuccess';
  const PaymentSuccess({super.key});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  void initState() {
    super.initState();
    st.add(true);
  }

  @override
  void dispose() {
    // st.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var receiver = context.read<ReceiverProvider>();
    // st.add(true);
    DateTime utcTime = DateTime.now();
    String formattedTime =
        DateFormat("MMMM d, yyyy 'at' h:mm a").format(utcTime);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: MediaQuery.of(context).size.width * 0.5,
                    color: Constants.yellowColor,
                  ),
                  Constants.gap,
                  Constants.gap,
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "${receiver.amount!}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 72,
                        )),
                    const TextSpan(
                        text: " pts",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        )),
                  ])),
                  Constants.gap,
                  Constants.gap,
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                        text: "Paid to ",
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 24,
                        )),
                    TextSpan(
                        text: receiver.userName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                  ])),
                  Text(receiver.userEmail,
                      style: const TextStyle(
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              const SizedBox(),
              Column(
                children: [
                  Text(formattedTime, style: const TextStyle(fontSize: 16)),
                  Constants.gap,
                  FilledButton(
                    onPressed: () {
                      Provider.of<ReceiverProvider>(context, listen: false).resetProvider();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Constants.yellowColor),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Constants.blackColor)),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
