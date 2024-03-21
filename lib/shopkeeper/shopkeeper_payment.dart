import 'package:apoorv_app/providers/shopkeeper_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/receiver_provider.dart';
import '../screens/homepage/Transactions/payment_success.dart';
import '../widgets/dialog.dart';
import '../widgets/snackbar.dart';
import '../widgets/spinning_apoorv.dart';

class Payment extends StatefulWidget {
  static const routeName = '/payment';
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final TextEditingController cardIdController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  int amount = 0;

  Future<Map<String, dynamic>>? _myFuture;

  var isProcessing = false;

  @override
  void initState() {
    super.initState();
    var to_uid = "123457";
    Provider.of<ReceiverProvider>(context, listen: false).setUID(to_uid);
    _myFuture = Provider.of<ReceiverProvider>(context, listen: false)
        .setReceiverData(context);
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    cardIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _myFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Scaffold(
              body: Center(
                child: SpinningApoorv(),
              ),
            );

          case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(child: Text(snapshot.error.toString())),
              );
            } else if (snapshot.hasData) {
              // print(snapshot.data);
              if (snapshot.data['success']) {
                return Scaffold(
                  appBar: AppBar(
                      // title: const IconButton(onPressed: null, icon: Icon(Icons.arrow_back)),
                      ),
                  body: Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                      bottom: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                context
                                    .read<ReceiverProvider>()
                                    .profilePhotoUrl!,
                              ),
                              radius: MediaQuery.of(context).size.width * 0.2,
                            ),
                            Constants.gap,
                            Constants.gap,
                            Text(
                              "Paying ${context.read<ReceiverProvider>().userName}",
                              style: const TextStyle(fontSize: 24),
                            ),
                            Text(
                              context.read<ReceiverProvider>().userEmail,
                              style: const TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 160,
                                    child: TextField(
                                      controller: amountController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(4),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        hintText: '0',
                                      ),
                                      style: const TextStyle(
                                          fontSize: 72, color: Colors.white),
                                    ),
                                  ),
                                  const Text(
                                    "pts",
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Stack(
                        //   alignment: Alignment.center,
                        //   children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          child: FilledButton(
                            onPressed: isProcessing
                                ? null
                                : () async {
                                    if (amountController.text.isNotEmpty &&
                                        int.parse(amountController.text) > 0) {
                                      if (!isProcessing) {
                                        setState(() {
                                          isProcessing = true;
                                        });
                                      }
                                      var response =
                                          await Provider.of<ShopkeeperProvider>(
                                        context,
                                        listen: false,
                                      ).doATransaction(
                                              context
                                                  .read<ReceiverProvider>()
                                                  .uid,
                                              amount,
                                              int.parse(cardIdController.text));
                                      setState(() {
                                        isProcessing = false;
                                      });

                                      if (context.mounted) {
                                        if (response['success']) {
                                          Provider.of<ReceiverProvider>(context,
                                                  listen: false)
                                              .setAmount(
                                            int.parse(amountController.text),
                                          );

                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  PaymentSuccess.routeName);
                                        } else {
                                          dialogBuilder(
                                            context,
                                            message: response['message'],
                                            function: () =>
                                                Navigator.of(context).pop(),
                                          );
                                          showSnackbarOnScreen(
                                              context, response['message']);
                                        }
                                      }
                                    } else {
                                      showSnackbarOnScreen(
                                          context, "Amount must be positive!");
                                    }
                                  },
                            child: Container(
                              height: 48,
                              alignment: Alignment.center,
                              child: Container(
                                height: 48,
                                alignment: Alignment.center,
                                child: isProcessing
                                    ? const SpinningApoorv()
                                    : const Text(
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
              } else {
                Future.delayed(
                  Duration.zero,
                  () => showSnackbarOnScreen(
                      context, snapshot.data['message'] + 'in else'),
                );
                return Center(child: Text(snapshot.data['message']));
              }
            } else {
              return const Scaffold(body: Center(child: SpinningApoorv()));
            }
        }
      },
    );
  }
}
