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

  String idToken = "";

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

  void refreshIdToken() {
    // void refreshIdToken() async {
    // idToken = (await FirebaseAuth.instance.currentUser!.getIdToken())!;
    // print(idToken);
    // notifyListeners();
    idToken = FirebaseAuth.instance.currentUser!.uid;
    notifyListeners();
    // (FirebaseAuth.instance.currentUser!.getIdToken()).then((value) {
    //   if (value != null) {
    //     idToken = value;
    //     notifyListeners();
    //   }
    // });
  }
}
