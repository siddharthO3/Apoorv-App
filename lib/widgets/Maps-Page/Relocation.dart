import 'package:flutter/material.dart';

class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/wolf.png'),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(20),
          )),
    );
  }
}
