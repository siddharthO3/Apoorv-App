import 'package:apoorv_app/screens/signup-flow/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';

class WelcomeScreen extends StatefulWidget{
  const WelcomeScreen({super.key});
  static const routeName = '/welcome';
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>{

  bool popStatus = true;
  int popCount=0;

  @override
  void initState() {
    super.initState();
    popScreen(context);
  }

  Future <void> popScreen(BuildContext context) async{
    popStatus = await Navigator.maybePop(context);
    if (mounted) {
      setState(() {});
    }
  }

  void showAppCloseConfirmation (BuildContext context){
    final snackBar = SnackBar(
        content: Text("Press back again to exit"),
        backgroundColor: Colors.white,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  Widget build(BuildContext context) {
    return PopScope(child:
    Scaffold(
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
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        Navigator.of(context)
                          .pushReplacementNamed(SignUpScreen.routeName);

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
          )
        ),
      ),
      canPop: popStatus,
      onPopInvoked: (bool didPop) async{
        if (didPop) {
          return;
        }
        popCount+=1;
        if (popCount==1){
          showAppCloseConfirmation(context);
          setState(() {
            popStatus = true;
          });
        }
      },
    );

  }
}
