import 'package:apoorv_app/providers/shopkeeper_provider.dart';
import 'package:apoorv_app/shopkeeper/shopkeeper_payment.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/receiver_provider.dart';
import '../widgets/snackbar.dart';

class ShopkeeperScanQR extends StatelessWidget {
  ShopkeeperScanQR({super.key});

  var _screenOpened = false;

  Future<dynamic>? scanQRDialog(BuildContext context) {
    var cameraController = MobileScannerController();
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        // backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
        content: SizedBox(
          height: MediaQuery.of(ctx).size.width * 0.8,
          width: MediaQuery.of(ctx).size.width * 0.8,
          child: MobileScanner(
            controller: cameraController,
            onDetect: (barcodes) async {
              if (!_screenOpened) {
                final String? code = barcodes.barcodes[0].rawValue;
                print("Screen opening now\nWith value: $code");
                _screenOpened = true;
                Map<String, dynamic> response =
                    await Provider.of<ShopkeeperProvider>(context,
                            listen: false)
                        .getUserInfo();
                if (context.mounted) {
                  if (response['success']) {
                    Provider.of<ReceiverProvider>(context, listen: false)
                        .resetProvider();
                    Provider.of<ReceiverProvider>(context, listen: false)
                        .setUID(code!);
                    Navigator.of(context)
                        .popAndPushNamed(ShopkeeperPayment.routeName);
                  } else {
                    showSnackbarOnScreen(context, "Try again");
                  }
                }
                // ScaffoldMessenger.of(context)
                //     .showSnackBar(SnackBar(content: Text(code!)));
                // for(int i=0; i< barcodes.barcodes.length; i++)
                // {
                //   var b = barcodes.barcodes[i];
                //   print("${i}th barcode gave this value: ${b.rawValue}");
                // }
                // Navigator.of(context).pop();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        scanQRDialog(context);
        // Navigator.of(context).pushNamed(ShopkeeperPayment.routeName);
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
              const Text('SCAN',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              const Text('QR CODE',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              // Constants.gap,
            ],
          ),
        ),
      ),
    );
  }
}
