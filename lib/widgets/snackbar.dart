import 'package:flutter/material.dart';

void showSnackbarOnScreen(BuildContext context, String content) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}