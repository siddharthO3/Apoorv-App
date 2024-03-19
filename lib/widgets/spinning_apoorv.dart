import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SpinningApoorv extends StatelessWidget {
  final String imagePath = 'assets/images/phoenix_74.png';

  const SpinningApoorv({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath).animate().rotate(
          curve: const ElasticInOutCurve(),
          duration: const Duration(seconds: 2),
        );
    //     Animate.rotate(
    //   from: 0,
    //   to: 360,
    //   duration: Duration(seconds: 2),
    //   builder: (context, child, value) {
    //     return Transform.rotate(
    //       angle: value * 3.141592653589793 / 180, // Convert degrees to radians
    //       child: Image.asset(imagePath),
    //     );
    //   },
    // ),
    //   ],
    // );
  }
}
