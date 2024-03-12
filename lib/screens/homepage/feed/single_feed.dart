import 'package:apoorv_app/constants.dart';
import 'package:flutter/material.dart';

class SingleFeed extends StatelessWidget {
  const SingleFeed({
    super.key,
    required this.title,
    required this.priority,
    this.imageUrl,
  });
  final String title;
  final int priority;
  final String? imageUrl;

  static const feedColor = {
    1: Constants.redColor,
    2: Constants.creamColor,
    3: Constants.silverColor,
    4: Constants.greyColor,
  };

  static const textColor = {
    1: Constants.whiteColor,
    2: Constants.blackColor,
    3: Constants.blackColor,
    4: Constants.silverColor,
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      // decoration: BoxDecoration(color: feedColor[priority]),
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.03,
        right: MediaQuery.of(context).size.width * 0.03,
        bottom: MediaQuery.of(context).size.width * 0.03,
      ),
      color: feedColor[priority],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset("assets/images/Apoorv.png"),
                const SizedBox(width: 16),
                Expanded(
                    child: Text(
                  title,
                  style: TextStyle(
                    color: textColor[priority],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )),
              ],
            ),

            if (imageUrl != null) ...{
              Constants.gap,
              Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
            }
          ],
        ),
      ),
    );
  }
}
