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
    4: Constants.whiteColor,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageUrl == null) ...{
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 100,
            decoration: BoxDecoration(
              color: feedColor[priority],
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: ListTile(
              leading: Image.asset("assets/images/Apoorv.png"),
              title: Text(
                title,
                style: TextStyle(
                  color: textColor[priority],
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        } else ...{
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 80,
            decoration: BoxDecoration(
              color: feedColor[priority],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: ListTile(
              leading: Image.asset("assets/images/Apoorv.png"),
              title: Text(
                title,
                style: TextStyle(
                  color: textColor[priority],
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 300,
              decoration: BoxDecoration(
                color: feedColor[priority],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 290,
                  margin: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
        }
      ],
    );
  }
}
