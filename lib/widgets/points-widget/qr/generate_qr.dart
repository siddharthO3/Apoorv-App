import 'package:apoorv_app/widgets/signup-flow/qr_helper.dart';
import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';

import '../../../constants.dart';

class GenerateQR extends StatelessWidget {
  const GenerateQR({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ShowCentreDialog(context).qrDialog(),
      child: Card(
        color: Constants.yellowColor,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.qr_code_rounded,
                size: MediaQuery.of(context).size.width * 0.25,
                color: Colors.black,
              ),
              const Text('SHOW',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              const Text('QR CODE',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
