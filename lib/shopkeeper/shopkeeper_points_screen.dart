import 'dart:async';

import 'package:apoorv_app/providers/shopkeeper_provider.dart';
import 'package:apoorv_app/shopkeeper/shopkeeper_all_transactions.dart';
import 'package:apoorv_app/shopkeeper/shopkeeper_scan_qr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../widgets/dialog.dart';
import '../widgets/spinning_apoorv.dart';

StreamController<bool> shopst = StreamController<bool>.broadcast();

class ShopkeeperPointsScreen extends StatefulWidget {
  static const routeName = '/shopkeeper-points';
  final Stream<bool>? stream;
  const ShopkeeperPointsScreen({this.stream, super.key});
  @override
  State<ShopkeeperPointsScreen> createState() => _ShopkeeperPointsScreenState();
}

class _ShopkeeperPointsScreenState extends State<ShopkeeperPointsScreen> {
  var myFuture;
  @override
  void initState() {
    super.initState();
    getTransactionHistory();
    if (widget.stream != null) {
      widget.stream!.listen((event) {
        if (event) {
          getTransactionHistory();
        }
      });
    }
  }

  Future<void> getTransactionHistory() async {
    Provider.of<ShopkeeperProvider>(context, listen: false).getUserInfo();
    if (context.mounted) {
      setState(() {
        myFuture = Provider.of<ShopkeeperProvider>(context, listen: false)
            .getLatest2Transactions();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myFuture,
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
                var message =
                    "There was a connection error! Check your connection and try again";

                Future.delayed(
                    const Duration(seconds: 1),
                    () =>
                        dialogBuilder(context, message: message, function: () {
                          getTransactionHistory();
                          Navigator.of(context).pop();
                        }));

                return const Scaffold(body: Center(child: SpinningApoorv()));
              } else if (snapshot.hasData) {
                if (snapshot.data['success']) {
                  Provider.of<ShopkeeperProvider>(context);
                  var providerContext = context.read<ShopkeeperProvider>();

                  return Scaffold(
                    resizeToAvoidBottomInset: false,
                    floatingActionButton: FloatingActionButton(
                      onPressed: () => getTransactionHistory(),
                      child: const Icon(Icons.refresh_rounded),
                    ),
                    body: Container(
                      // height: MediaQuery.of(context).size.height -
                      //     kBottomNavigationBarHeight,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Constants.gradientHigh,
                            Constants.gradientLow
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.center,
                        ),
                      ),
                      // color: Constants.yellowColor,
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            // Constants.gap,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  context
                                      .read<ShopkeeperProvider>()
                                      .shopPoints
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 72,
                                    fontWeight: FontWeight.bold,
                                    color: Constants.blackColor,
                                  ),
                                ),
                                const Text(
                                  "Shop Points",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36,
                                    color: Constants.blackColor,
                                  ),
                                ),
                              ],
                            ),
                            // Constants.gap,
                            Container(
                              // Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Constants.blackColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.05),
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      "LAST TRANSACTIONS",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                      ),
                                    ),
                                    if (providerContext
                                        .transactions.isEmpty) ...[
                                      Constants.gap,
                                      const Center(
                                        child: Text(
                                            "No transactions to show here"),
                                      ),
                                      // Constants.gap,
                                    ],
                                    if (providerContext.transactions.isNotEmpty)
                                      ...snapshot.data['transactions'],
                                    // Constants.gap,
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: providerContext
                                                .transactions.isNotEmpty
                                            ? () {
                                                Navigator.of(context)
                                                    .restorablePushNamed(
                                                        ShopkeeperAllTransactions
                                                            .routeName);
                                              }
                                            : null,
                                        // Disable the button if there are no transactions
                                        style: const ButtonStyle(),
                                        child: const Text(
                                          'View More ->',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          // textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ),
                                    // Constants.gap,
                                    Center(child: ShopkeeperScanQR()),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Constants.gap,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ),
                    ),
                  );
                } else {
                  // Future.delayed(
                  //   Duration.zero,
                  //   () =>
                  //       showSnackbarOnScreen(context, snapshot.data['message']),
                  // );
                  return Center(child: Text(snapshot.data['message']));
                }
              } else {
                return const Scaffold(body: Center(child: SpinningApoorv()));
              }
          }
        });
  }
}
