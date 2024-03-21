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

class ShopkeeperPayment extends StatefulWidget {
  static const routeName = '/shopkeeper-payment';
  const ShopkeeperPayment({super.key});

  @override
  State<ShopkeeperPayment> createState() => _PaymentState();
}

class _PaymentState extends State<ShopkeeperPayment> {
  final TextEditingController cardIdController = TextEditingController();
  int amount = 0;

  Future<Map<String, dynamic>>? _myFuture;

  var isProcessing = false;
  bool isDisable = true;
  @override
  void initState() {
    super.initState();
    _myFuture = Provider.of<ReceiverProvider>(context, listen: false)
        .setReceiverData(context, shop: true);
  }

  @override
  void dispose() {
    super.dispose();
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
                    child: LayoutBuilder(
                      builder: (context, constraints) => SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
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
                                    radius:
                                        MediaQuery.of(context).size.width * 0.2,
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
                                  Constants.gap,
                                  SizedBox(
                                      child: Wrap(
                                    spacing: 16,
                                    runSpacing: 8,
                                    alignment: WrapAlignment.spaceAround,
                                    children: context
                                        .read<ShopkeeperProvider>()
                                        .pointsArray
                                        .map((e) {
                                      return FilledButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith(
                                                        (states) => null)),
                                        onPressed: () {
                                          setState(() {
                                            isDisable = false;
                                            amount = e;
                                          });
                                        },
                                        child: Text(
                                          "$e pts",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      );
                                    }).toList(),
                                  )),
                                  Constants.gap,
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.33,
                                    child: TextFormField(
                                        controller: cardIdController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter Amount";
                                          }
                                          return null;
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(5),
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        keyboardType: TextInputType.phone,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          hintText: "Card ID",
                                        )),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                              // Stack(
                              //   alignment: Alignment.center,
                              //   children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                                child: FilledButton(
                                  onPressed: isDisable
                                      ? null
                                      : isProcessing
                                          ? null
                                          : () async {
                                              if (cardIdController
                                                  .text.isNotEmpty) {
                                                if (!isProcessing) {
                                                  setState(() {
                                                    isProcessing = true;
                                                  });
                                                }
                                                var response = await Provider
                                                    .of<ShopkeeperProvider>(
                                                  context,
                                                  listen: false,
                                                ).doATransaction(
                                                    context
                                                        .read<
                                                            ReceiverProvider>()
                                                        .uid,
                                                    amount,
                                                    int.parse(
                                                        cardIdController.text));
                                                setState(() {
                                                  isProcessing = false;
                                                });

                                                if (context.mounted) {
                                                  if (response['success']) {
                                                    Provider.of<ReceiverProvider>(
                                                            context,
                                                            listen: false)
                                                        .setAmount(
                                                      amount,
                                                    );

                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            PaymentSuccess
                                                                .routeName);
                                                  } else {
                                                    dialogBuilder(
                                                      context,
                                                      message:
                                                          response['message'],
                                                      function: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                    );
                                                    showSnackbarOnScreen(
                                                        context,
                                                        response['message']);
                                                  }
                                                }
                                              } else {
                                                showSnackbarOnScreen(
                                                    context, "Enter card id!");
                                              }
                                            },
                                  child: Container(
                                    height: 48,
                                    alignment: Alignment.center,
                                    child: isDisable
                                        ? Container(
                                            height: 48,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Select Points',
                                              style: TextStyle(fontSize: 20),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : Container(
                                            height: 48,
                                            alignment: Alignment.center,
                                            child: isProcessing
                                                ? const SpinningApoorv()
                                                : Text(
                                                    'Paying $amount points',
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                    textAlign: TextAlign.center,
                                                  ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
