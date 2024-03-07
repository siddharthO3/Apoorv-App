import 'dart:io';

import 'package:flutter/material.dart';

class Content {
  const Content({
    required this.txtcolor,
    required this.body,
    required this.color,
    this.image,
  });
  final String body;
  final Color color;
  final Color txtcolor;
  final Image? image;
}
