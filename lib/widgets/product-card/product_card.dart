import 'package:flutter/material.dart';

import '../../constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 19,
        top: 20,
        bottom: 20,
      ),
      child: GestureDetector(
        onTap: () {
          print('hi');
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
              border: Border.all(
                color: Constants.yellowColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline,
                            color: Constants.yellowColor,
                            size: 29,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(right: 9),
                          height: MediaQuery.of(context).size.height / 3.5,
                          width: MediaQuery.of(context).size.width / 3,
                          child: Image.asset("assets/images/phoenix_red_title.png"),
                        ),
                      ),
                      const Text(
                        "T-Shirt Half",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Constants.creamColor,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text("Graphic Cotton half sleeves",
                          style: TextStyle(
                            color: Constants.yellowColor,
                            fontSize: 17,
                          )),
                      const SizedBox(
                        height: 12,
                      ),
                      const Row(
                        children: [
                          Text(
                            "\u{20B9} 299.99",
                            style: TextStyle(
                              color: Constants.yellowColor,
                              fontSize: 19,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
