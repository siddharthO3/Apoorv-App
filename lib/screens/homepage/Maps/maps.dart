import 'package:apoorv_app/widgets/Maps-Page/Landing_page.dart';
import 'package:apoorv_app/widgets/Maps-Page/map.dart';
import 'package:flutter/material.dart';

import '../../../utils/dummy_data/mock_data.dart';

class MapsScreen extends StatefulWidget {
  MapsScreen({
    super.key,
  });

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final List Dummy = dummy;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListView.builder(
            itemCount: Dummy.length,
            itemBuilder: (BuildContext context, int index) {
              final Content = Dummy[index];

              return Column(
                children: [
                  MapList(
                    body: Content.body,
                    color: Content.color,
                    txtColor: Content.txtcolor,
                    fun: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LandingPage(image: Content.image ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            }),
      
    );
  }
}
