import 'package:apoorv_app/widgets/Feed_Page/feed_list.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../utils/dummy_data/mock_data.dart';

// ignore: non_constant_identifier_names
final List Dummy = dummy;

class FeedScreen extends StatelessWidget {
  static const routeName = '/feed';
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const String name = "Roronoa Zoro";

    return SafeArea(
      child: Material(
        child: SizedBox(
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
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 19,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              "Welcome,\n$name",
                              style: TextStyle(
                                color: Constants.blackColor,
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
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
              const Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Feed",
                    style: TextStyle(
                      color: Constants.whiteColor,
                      fontSize: 30,
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
                      // ignore: non_constant_identifier_names
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
