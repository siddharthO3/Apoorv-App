import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';

class FeedScreen extends StatelessWidget {
  static const routeName = '/feed';
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1.5,
                height: MediaQuery.of(context).size.height / 4,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Constants.gradientHigh, Constants.gradientLow],
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 19,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              "Welcome,\n Monkey D. Luffy",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Constants.blackColor,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/images/Apoorv-logo.png",
                      height: MediaQuery.of(context).size.height / 5.9,
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Feed",
                    style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                        color: Constants.whiteColor,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // ListView.builder( {
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 80,
                decoration: const BoxDecoration(
                  color: Constants.creamColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: ListTile(
                    leading: Image.asset("assets/images/Apoorv.png"),
                    title: Text(
                      "Treasure Hunt is Going to Start Soon, Please Gather at AB 201",
                      style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                          color: Constants.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // },)
            ],
          ),
        ),
      ),
    );
  }
}
