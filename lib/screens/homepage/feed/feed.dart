import 'package:apoorv_app/api.dart';
import 'package:apoorv_app/providers/user_info_provider.dart';
import 'package:apoorv_app/screens/homepage/feed/single_feed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class FeedScreen extends StatefulWidget {
  static const routeName = '/feed';
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Future<Map<String, dynamic>>? _myFuture;

  @override
  void initState() {
    super.initState();
    _myFuture = APICalls().getFeed(context.read<UserProvider>().idToken);
  }

  @override
  Widget build(BuildContext context) {
    // const String name = "Roronoa Zoro";

    return FutureBuilder(
        future: _myFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text(snapshot.error.toString())),
                );
              } else if (snapshot.hasData) {
                print(snapshot.data);
                if (snapshot.data['success']) {
                  var providerContext = context.read<UserProvider>();

                  var data = snapshot.data['body'] as List;
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Constants.gradientHigh,
                                  Constants.gradientLow
                                ],
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
                                        "Welcome,\n${providerContext.userName}",
                                        style: const TextStyle(
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
                                height:
                                    MediaQuery.of(context).size.height / 5.9,
                                width: MediaQuery.of(context).size.width / 4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // const Align(
                        //   alignment: AlignmentDirectional.topStart,
                        //   child: Padding(
                        //     padding: EdgeInsets.only(left: 10.0),
                        //     child: Text(
                        //       "Feed",
                        //       style: TextStyle(
                        //         color: Constants.whiteColor,
                        //         fontSize: 30,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          width: double.infinity,
                          child: const Text(
                            "Feed",
                            style: TextStyle(
                              color: Constants.whiteColor,
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // ListView.builder( {
                        Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int i) {
                                if (data[i]['imageUrl'] != null) {
                                  return SingleFeed(
                                    title:
                                        "${data[i]['title']}\n${data[i]['text']}",
                                    priority: data[i]['priority'],
                                    imageUrl: data[i]['imageUrl'],
                                  );
                                } else {
                                  return SingleFeed(
                                    title:
                                        "${data[i]['title']}\n${data[i]['text']}",
                                    priority: data[i]['priority'],
                                  );
                                }
                              }),
                        ),
                      ],
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
                return const Scaffold(body: Text('No data'));
              }
          }
        });
  }
}
