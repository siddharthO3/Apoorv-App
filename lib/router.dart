
import 'package:flutter/material.dart';


class Routing extends StatelessWidget {
  const Routing({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
    // If no Firebase auth currentuser, then call welcomeScreen()
    // If Firebase auth currentuser present, and not in database then call signup screen
    // If firebase auth currentuser present, and in database then call homepage
  }
}
