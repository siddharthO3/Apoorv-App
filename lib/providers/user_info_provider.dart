import 'package:apoorv_app/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String userName;
  String? userCollegeName;
  String? userRollNo;
  String userPhNo;
  String? profilePhotoUrl;
  String userEmail;
  bool fromCollege = false;

  String uid = "";
  String idToken = "";

  int points = 0;

  UserProvider({
    this.userName = "Full Name",
    this.userCollegeName,
    this.userRollNo,
    this.userPhNo = "Phone Number",
    this.profilePhotoUrl,
    this.userEmail = " ",
  });

  void changeSameCollegeDetails({
    required String newUserName,
    required String newUserRollNo,
    required String newUserPhNo,
  }) {
    userName = newUserName;
    userPhNo = newUserPhNo;
    userCollegeName = 'IIIT Kottayam';
    userRollNo = newUserRollNo;
    notifyListeners();
  }

  void changeOtherCollegeDetails({
    required String newUserName,
    required String newUserCollegeName,
    required String newUserPhNo,
  }) {
    userName = newUserName;
    userPhNo = newUserPhNo;
    userCollegeName = newUserCollegeName;
    notifyListeners();
  }

  void updateProfilePhoto(String pf) {
    profilePhotoUrl = pf;
    notifyListeners();
  }

  void updateEmail(String em) {
    userEmail = em;
    notifyListeners();
  }

  void refreshUID() {
    uid = FirebaseAuth.instance.currentUser!.uid;
    notifyListeners();
  }

  void refreshIdToken() async {
    idToken = (await FirebaseAuth.instance.currentUser!.getIdToken())!;
    notifyListeners();
  }

  void updatePoints(int newPoints) {
    points = newPoints;
    notifyListeners();
  }

  Future<Map<String, dynamic>> updateProfileScreen() async {
    refreshUID();
    refreshIdToken();

    var res = await APICalls().getUserDataAPI(uid, idToken);
    print("res: $res");
    if (res['success']) {
      if (res['fromCollege']) {
        changeSameCollegeDetails(
          newUserName: res['fullName'],
          newUserRollNo: res['rollNumber'],
          newUserPhNo: res['phone'],
        );
      } else {
        changeOtherCollegeDetails(
          newUserName: res['fullName'],
          newUserCollegeName: res['collegeName'],
          newUserPhNo: res['phone'],
        );
      }
      updateEmail(res['email']);
      updatePoints(res['points']);
      notifyListeners();
    }
    return {
      'success': res['success'],
      'message': res['message'],
    };
  }

  Future<Map<String, dynamic>> doATransaction(String to, int amount) async {
    refreshUID();
    var response = await APICalls().transactionAPI(uid, to, amount);
    print("Response from provider-> $response");
    if (response['success']) {
      notifyListeners();
    }
    return response;
  }
}
