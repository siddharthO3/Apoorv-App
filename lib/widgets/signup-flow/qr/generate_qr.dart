import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';

import '../../../utils/constants.dart';

class GenerateQR extends StatelessWidget {
  const GenerateQR({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.yellowColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Expanded(
            //   child: QrImageView(
            //     data: 'Siddharth',
            //     // size: MediaQuery.of(context).size.width * 0.25,
            //   ),
            // ),
            // Constants.gap,
            Icon(
              Icons.qr_code_rounded,
              size: MediaQuery.of(context).size.width * 0.25,
              color: Colors.black,
            ),
            const Text('SHOW', style: TextStyle(color: Colors.black)),
            const Text('QR CODE', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
