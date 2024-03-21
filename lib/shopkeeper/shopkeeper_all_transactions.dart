import 'package:apoorv_app/providers/shopkeeper_provider.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AllTransactions extends StatelessWidget {
  static const routeName = '/all-transactions';
  const AllTransactions({super.key});

  Future<void> fetchAllTransactions(BuildContext context) async {
    await Provider.of<ShopkeeperProvider>(context, listen: false)
        .getUserTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
      body: CustomMaterialIndicator(
        indicatorBuilder: (context, controller) =>
            Image.asset("assets/images/phoenix_74.png"),
        onRefresh: () => fetchAllTransactions(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Constants.gradientHigh,
                          Constants.gradientMid,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: const EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          child: const Icon(
                            Icons.arrow_back_outlined,
                            size: 30,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Text(
                          "All Transactions",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Constants.gap,
                        const Text(
                          "Transactions",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          "Please refresh the page to update your transactions!",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03),
                      child: ListView.builder(
                        itemBuilder: (context, i) =>
                            context.read<ShopkeeperProvider>().transactions[i],
                        itemCount:
                            context.read<ShopkeeperProvider>().transactions.length,
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
  }
}
