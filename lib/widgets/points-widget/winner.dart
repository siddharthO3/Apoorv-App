import 'package:apoorv_app/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class Winner extends StatelessWidget {
  final String? image;
  final String? name;
  final int? points;
  final String? uid;

  const Winner({
    super.key,
    this.image,
    this.name,
    this.points,
    this.uid,
  });

  @override
  Widget build(BuildContext context) {
    Decoration? decoration;
    if (uid == Provider.of<UserProvider>(context, listen: false).uid) {
      decoration = BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.red[100]!,
          width: 6,
        ),
      );
    }
    return Column(
      children: [
        Container(
          decoration: decoration,
          child: CircleAvatar(
              backgroundImage: NetworkImage(image ?? ''),
              radius: 50,
              child: const Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.emoji_events,
                      color: Constants.redColor,
                      size: 40,
                    ),
                  )
                ],
              )),
        ),
        Text(
          name!,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$points",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(
              Icons.stars,
              color: Colors.white,
              size: 16,
            )
          ],
        )
      ],
    );
  }
}
