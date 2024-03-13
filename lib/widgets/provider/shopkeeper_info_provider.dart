import 'package:flutter/material.dart';

class ShopkeeperProvider extends ChangeNotifier {
  String shopkeeperEmail;
  String shopkeeperPassword;

  ShopkeeperProvider({
    this.shopkeeperEmail = " ",
    this.shopkeeperPassword = " ",
  });

  void updateShopkeeper({
    required String shopEmail,
    required String shopPass,
  }) {
    shopkeeperEmail = shopEmail;
    shopkeeperPassword = shopPass;
    notifyListeners();
  }
}
