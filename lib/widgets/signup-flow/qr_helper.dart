import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../constants.dart';

class ShowCentreDialog {
  final BuildContext context;
  ShowCentreDialog(this.context);
  var _screenOpened = false;

  Future<dynamic>? qrDialog() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Container(
          height: MediaQuery.of(ctx).size.width * 0.77,
          width: MediaQuery.of(ctx).size.width * 0.8,
          alignment: Alignment.center,
          child: QrImageView(
            data: 'Siddharth',
            backgroundColor: Constants.whiteColor,
            // size: MediaQuery.of(ctx).size.width * 0.75,
          ),
        ),
      ),
    );
  }

  Future<dynamic>? scanQRDialog() {
    var cameraController = MobileScannerController();
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: SizedBox(
          height: MediaQuery.of(ctx).size.width * 0.8,
          width: MediaQuery.of(ctx).size.width * 0.8,
          child: MobileScanner(
            controller: cameraController,
            onDetect: (barcodes) {
              if (!_screenOpened) {
                final String? code = barcodes.barcodes[0].rawValue;
                // print("Screen opening now\nWith value: $code");
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(code!)));
                // for(int i=0; i< barcodes.barcodes.length; i++)
                // {
                //   var b = barcodes.barcodes[i];
                //   print("${i}th barcode gave this value: ${b.rawValue}");
                // }
                Navigator.of(context).pop();

                _screenOpened = true;
              }
            },
          ),
        ),
      ),
    );
  }
}
