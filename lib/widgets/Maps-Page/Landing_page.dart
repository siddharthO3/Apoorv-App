import 'dart:ui';

import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
   this.image,
  });

  final Image? image;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/BestPhoenix.png'),
            fit: BoxFit.contain,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Center(
              child:Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image?.image ?? AssetImage('assets/images/wolf.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
          ),
        ),
      ),
    );
  }
}
