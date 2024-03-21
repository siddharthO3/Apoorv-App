import 'package:apoorv_app/api.dart';
import 'package:apoorv_app/providers/shopkeeper_provider.dart';
import 'package:apoorv_app/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiverProvider extends ChangeNotifier {
  String userName = "John Doe";
  String? profilePhotoUrl;
  String userEmail = "example@noreply.com";

  String uid = "";

  int? amount;

  bool fromSearch = false;

  void resetProvider() {
    fromSearch = false;
    userName = "John Doe";
    profilePhotoUrl = null;
    userEmail = "example@noreply.com";
    uid = "";
  }

  void updateProfilePhoto(String pf) {
    profilePhotoUrl = pf;
    notifyListeners();
  }

  void getReceiverDetails({
    required String uid,
    required String name,
    required String email,
  }) {
    this.uid = uid;
    userName = name;
    userEmail = email;
    notifyListeners();
  }

  void setAmount(int amt) {
    amount = amt;
  }

  void setUID(String newUID) {
    uid = newUID;
    notifyListeners();
  }

  void setReceiverDataFromSearch(Map<String, dynamic> args) {
    fromSearch = true;

    uid = args['uid'];
    userName = args['fullName'];
    userEmail = args['email'];
    updateProfilePhoto(args['profileImage']);
  }

  Future<Map<String, dynamic>> setReceiverData(BuildContext context,
      {bool shop = false}) async {
    var response;
    if (shop) {
      Provider.of<ShopkeeperProvider>(context, listen: false).refreshIdToken();
      response = await APICalls()
          .getUserDataAPI(uid, context.read<ShopkeeperProvider>().idToken);
    } else {
      Provider.of<UserProvider>(context, listen: false).refreshIdToken();
      response = await APICalls()
          .getUserDataAPI(uid, context.read<UserProvider>().idToken);
    }

    var retValue = {'success': false};

    if (response['success']) {
      getReceiverDetails(
        uid: uid,
        name: response['fullName'],
        email: response['email'],
      );

      updateProfilePhoto(response['photoUrl']);

      retValue['success'] = true;
      // notifyListeners();
    }
    return retValue;
  }
}
