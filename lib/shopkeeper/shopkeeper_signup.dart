import 'package:apoorv_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/shopkeeper_provider.dart';
import 'shopkeeper_homepage.dart';

class ShopkeeperSignIn extends StatefulWidget {
  static const routeName = '/shopkeeper-signin';
  const ShopkeeperSignIn({super.key});

  @override
  State<ShopkeeperSignIn> createState() => _ShopkeeperSignInState();
}

class _ShopkeeperSignInState extends State<ShopkeeperSignIn> {
  late final TextEditingController shopkeeperEmailController;
  final TextEditingController shopkeeperPassController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    shopkeeperEmailController.dispose();
    shopkeeperPassController.dispose();
    super.dispose();
  }

  bool isChecked = true;
  bool popStatus = true;
  bool passwordVisible = false;
  int popCount = 0;

  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    Provider.of<ShopkeeperProvider>(context, listen: false)
        .refreshGoogleServiceData();
    popScreen(context);
    shopkeeperEmailController = TextEditingController(
        text: Provider.of<ShopkeeperProvider>(context, listen: false)
            .shopkeeperEmail);
    passwordVisible = true;
  }

  Future<void> popScreen(BuildContext context) async {
    popStatus = await Navigator.maybePop(context);
    if (mounted) {
      setState(() {});
    }
  }

  void showAppCloseConfirmation(BuildContext context) {
    const snackBar = SnackBar(
      content: Text("Press back again to exit"),
      backgroundColor: Colors.white,
    );
    popCount += 1;
    if (popCount == 1) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        popStatus = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var shopkeeperProvider = Provider.of<ShopkeeperProvider>(context);
    return PopScope(
      canPop: popStatus,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        showAppCloseConfirmation(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                // reverse: false,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'Enter ',
                                style: TextStyle(color: Constants.yellowColor)),
                            TextSpan(
                                text: 'Your ',
                                style: TextStyle(color: Constants.redColor)),
                            TextSpan(
                                text: 'Shop Details',
                                style: TextStyle(color: Constants.yellowColor)),
                          ],
                          style: TextStyle(
                              fontFamily: 'Libre Baskerville', fontSize: 22),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Icon(
                        Icons.account_circle_outlined,
                        color: Constants.yellowColor,
                        size: MediaQuery.of(context).size.width * 0.4,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                                enabled: false,
                                controller: shopkeeperEmailController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  filled: true,
                                  fillColor: Constants.yellowColor,
                                  hintText: "Email",
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                )),
                            Constants.gap,
                            TextFormField(
                              controller: shopkeeperPassController,
                              obscureText: passwordVisible,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password Required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  filled: true,
                                  fillColor: Constants.yellowColor,
                                  hintText: 'Password',
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                  )),
                            ),
                            Constants.gap,
                            FilledButton(
                              onPressed: isProcessing
                                  ? null
                                  : () async {
                                      if (!isProcessing) {
                                        setState(() {
                                          isProcessing = true;
                                        });
                                      }
                                      if (_formKey.currentState!.validate()) {
                                        shopkeeperProvider.updateShopkeeper(
                                          shopEmail:
                                              shopkeeperEmailController.text,
                                          shopPass:
                                              shopkeeperPassController.text,
                                        );
                                        var shopProvider =
                                            Provider.of<ShopkeeperProvider>(
                                                context,
                                                listen: false);

                                        shopProvider.shopkeeperPassword =
                                            shopkeeperPassController.text;

                                        var response =
                                            await shopProvider.getUserInfo();
                                        if (response['success']) {
                                          Navigator.of(context)
                                              .restorablePushReplacementNamed(
                                                  ShopkeeperHomePage.routeName);
                                        } else {
                                          showSnackbarOnScreen(context,
                                              "Incorrect password login");
                                        }
                                      }
                                    },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Constants.redColor),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
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
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom))
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        // ),
      ),
    );
  }
}
