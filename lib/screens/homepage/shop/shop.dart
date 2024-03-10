import 'package:apoorv_app/utils/dummy_data/Product_data.dart';

import '../../../../constants.dart';
// import 'package:apoorv_app/screens/homepage/Profile/profile.dart';
import 'package:apoorv_app/widgets/product-card/product_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/services.dart';

final List Data = data;

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Constants.blackColor,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Limited Time Offers",
                      style: GoogleFonts.lora(
                        textStyle: const TextStyle(
                          color: Constants.yellowColor,
                          fontSize: 28.5,
                        ),
                      ),
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
                      for (var i = 0; i < Data.length; i++)
                        ProductCard(
                          name: Data[i].name,
                          img: Data[i].img,
                          price: Data[i].price,
                          description: Data[i].description,
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          "Deals",
                          style: GoogleFonts.lora(
                            textStyle: const TextStyle(
                              color: Constants.yellowColor,
                              fontSize: 28.5,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          "View all",
                          style: GoogleFonts.lora(
                            textStyle: const TextStyle(
                              color: Constants.yellowColor,
                              fontSize: 28.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          width: 10),
                      for (var i = 0; i < Data.length; i++)
                        ProductCard(
                          name: Data[i].name,
                          img: Data[i].img,
                          price: Data[i].price,
                          description: Data[i].description,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
