import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MapList extends StatelessWidget {
  const MapList(
      {super.key,
      required this.color,
      required this.body,
      required this.txtColor, required this.fun});

  final Color color;
  final String body;
  final Color txtColor;
  final VoidCallback fun;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 90,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: GestureDetector(
        onTap: fun,
        child: ListTile(
          leading: Image.asset("assets/images/Apoorv.png"),
          title: Text(
            body,
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: txtColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
