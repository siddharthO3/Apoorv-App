import 'package:apoorv_app/providers/shopkeeper_provider.dart';
import 'package:apoorv_app/shopkeeper/shopkeeper_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../widgets/signup-flow/sign_in_with_google.dart';
import '../widgets/snackbar.dart';

class ShopKeeperWelcomeScreen extends StatefulWidget {
  const ShopKeeperWelcomeScreen({super.key});
  static const routeName = '/shopkeeper-welcome';
  @override
  _ShopKeeperWelcomeScreenState createState() =>
      _ShopKeeperWelcomeScreenState();
}

class _ShopKeeperWelcomeScreenState extends State<ShopKeeperWelcomeScreen> {
  bool popStatus = true;
  int popCount = 0;

  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    popScreen(context);
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
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // int count=0;
    return PopScope(
      canPop: popStatus,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        popCount += 1;
        if (popCount == 1) {
          showAppCloseConfirmation(context);
          setState(() {
            popStatus = true;
          });
        }
      },
      child: Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.05),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/upscaled_phoenix_red_title.png'),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    width: double.infinity,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Constants.gradientLow,
                            Constants.gradientHigh
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        // color: Constants.yellowColor,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: FilledButton.icon(
                        onPressed: isProcessing
                            ? null
                            : () async {
                                if (!isProcessing) {
                                  setState(() {
                                    isProcessing = true;
                                  });
                                }
                                try {
                                  await signInWithGoogle(context);
                                  var auth = FirebaseAuth.instance;
                                  if (auth.currentUser != null) {
                                    if (context.mounted) {
                                      showSnackbarOnScreen(
                                          context, "User Signed in!");
                                      Provider.of<ShopkeeperProvider>(context,
                                              listen: false)
                                          .refreshGoogleServiceData();
                                      Navigator.of(context)
                                          .restorablePushReplacementNamed(
                                              ShopkeeperSignIn.routeName);
                                    }
                                  }
                                } catch (e) {
                                  showSnackbarOnScreen(
                                      context, "Choose a Google account");
                                  setState(() {
                                    isProcessing = false;
                                  });
                                }
                              },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent)),
                        icon: SizedBox(
                          height: 64,
                          child: isProcessing
                              ? null
                              : Image.asset(
                                  'assets/images/google.png',
                                  fit: BoxFit.contain,
                                ),
                        ),
                        label: isProcessing
                            ? const CircularProgressIndicator(
                                color: Constants.redColorAlt,
                              )
                            : const Text(
                                'Shopkeeper Sign-In',
                                style: TextStyle(
                                  fontSize: 20,
                                  // fontFamily: 'Inter',
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
