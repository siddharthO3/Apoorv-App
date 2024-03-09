import 'package:apoorv_app/api.dart';
import 'package:apoorv_app/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiverProvider extends ChangeNotifier {
  String userName = "John Doe";
  String? profilePhotoUrl;
  String userEmail = "example@noreply.com";

  String uid = "";

  int points = 0;

  // ReceiverProvider({
  //   this.userName = "Full Name",
  //   this.profilePhotoUrl,
  //   this.userEmail = "example@noreply.com",
  // });

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

  void setUID(String newUID) {
    uid = newUID;
    notifyListeners();
  }

  Future<Map<String, dynamic>> setReceiverData(BuildContext context) async {
    Provider.of<UserProvider>(context, listen: false).refreshIdToken();
    var response = await APICalls().getUserDataAPI(uid, context.read<UserProvider>().idToken);

    var retValue = {'success': false};

    if (response['success']) {
      getReceiverDetails(
        uid: uid,
        name: response['fullName'],
        email: response['email'],
      );

      retValue['success'] = true;
      // notifyListeners();
    }
    return retValue;
  }
}
