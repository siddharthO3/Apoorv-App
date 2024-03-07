import 'package:apoorv_app/widgets/Feed_Page/feed_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';
import '../../../utils/mock_data.dart';
import '../../../utils/Models/Feed.dart';

final List Dummy = dummy;

class FeedScreen extends StatelessWidget {
  static const routeName = '/feed';
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const String name = "Roronoa Zoro";

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
                              "Welcome,\n$name",
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
              Expanded(
                child: ListView.builder(
                    itemCount: Dummy.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Content = Dummy[index];
                
                      return FeedList(
                        body: Content.body,
                        color: Content.color,
                        txtColor: Content.txtcolor,
                        image: Content.image,
                      );
                    }),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
