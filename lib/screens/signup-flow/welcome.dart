import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.05),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/images/upscaled_phoenix_red_title.png'),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0xFF, 0xE8, 0xB4, 1),
                      padding: const EdgeInsets.all(12),
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 24,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SizedBox(
                          height: 64,
                          child: Image.asset(
                            'assets/images/google.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Text(
                          'Sign In with Google',
                          style:
                              TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    color: Colors.black,
                                  ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}