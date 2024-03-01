import 'package:apoorv_app/constants.dart';
// import 'package:apoorv_app/screens/homepage/Profile/profile.dart';
import 'package:apoorv_app/widgets/product-card/product_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/services.dart';

class ShopScreen extends StatelessWidget {
  static const routeName = '/shop';
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Constants.blackColor,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Limited Time Offers",
                style: GoogleFonts.lora(textStyle: const TextStyle(
                  color: Constants.yellowColor,
                  fontSize: 28.5,
                ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        width: 10),
                    const ProductCard(),
                    const ProductCard(),
                    const ProductCard(),
                    const ProductCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
