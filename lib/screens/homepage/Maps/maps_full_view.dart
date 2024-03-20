import 'package:flutter/material.dart';

class MapsFullView extends StatelessWidget {
  static const routeName = '/maps-full';
  const MapsFullView({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(args['text']),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height*0.8,
        child: SizedBox(
          width: double.infinity,
          child: Hero(
            tag: args['url'],
            child: InteractiveViewer(
              constrained: false,
              minScale: 0.5,
              // boundaryMargin: EdgeInsets.all(100),
              child: Image.network(
                args['url'],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
