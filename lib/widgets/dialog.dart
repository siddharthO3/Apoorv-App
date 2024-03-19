import 'package:flutter/material.dart';

import '../constants.dart';

Future<void> dialogBuilder(
  BuildContext context, {
  required String message,
  required VoidCallback function,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          message,
          style: const TextStyle(
            color: Constants.blackColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Constants.yellowColor,
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: Theme.of(context).textTheme.labelLarge,
                backgroundColor: Constants.blackColor),
            onPressed: function,
            child: const Text(
              'Try Again',
              style: TextStyle(color: Constants.whiteColor),
            ),
          ),
        ],
      );
    },
  );
}
