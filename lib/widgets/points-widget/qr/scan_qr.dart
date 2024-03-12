import 'package:apoorv_app/screens/homepage/Transactions/payment.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ScanQR extends StatelessWidget {
  const ScanQR({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ShowCentreDialog(context).scanQRDialog();
        Navigator.of(context).pushNamed(Payment.routeName);
      },
      child: Card(
        color: Constants.yellowColor,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Constants.gap,
              Icon(
                Icons.qr_code_scanner_rounded,
                size: MediaQuery.of(context).size.width * 0.25,
                color: Colors.black,
              ),
              const Text('SCAN', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              const Text('QR CODE', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
              // Constants.gap,
            ],
          ),
        ),
      ),
    );
  }
}
