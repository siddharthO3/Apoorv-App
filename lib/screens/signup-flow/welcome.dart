import 'package:apoorv_app/base_client.dart';
import 'package:apoorv_app/providers/user_info_provider.dart';
import 'package:apoorv_app/screens/signup-flow/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/signup-flow/sign_in_with_google.dart';
import '../../widgets/snackbar.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(BaseClient.baseUrl);
    return Scaffold(
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
                        colors: [Constants.gradientLow, Constants.gradientHigh],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      // color: Constants.yellowColor,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: FilledButton.icon(
                      onPressed: () async {
                        await signInWithGoogle();
                        var auth = FirebaseAuth.instance;
                        if (auth.currentUser != null) {
                          //TODO: Check context.mounted if it works

                          if (context.mounted) {
                          showSnackbarOnScreen(context, "User Signed in!");
                          Provider.of<UserProvider>(context, listen: false)
                              .updateEmail(auth.currentUser!.email!);
                            Navigator.of(context)
                                .pushNamed(SignUpScreen.routeName);
                          }
                          // BaseClient.printAuthTokenForTest();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent)),
                      icon: SizedBox(
                        height: 64,
                        child: Image.asset(
                          'assets/images/google.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      label: const Text(
                        'Sign In with Google',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Inter',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
