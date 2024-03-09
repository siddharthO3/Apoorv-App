// ignore_for_file: avoid_print

import 'package:apoorv_app/api.dart';
import 'package:apoorv_app/widgets/points-widget/transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProvider extends ChangeNotifier {
  String userName;
  String? userCollegeName;
  String? userRollNo;
  String userPhNo;
  String? profilePhotoUrl;
  String userEmail;
  bool fromCollege = false;

  List<TransactionsWidget> transactions = [];

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
    fromCollege = true;
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
    fromCollege = false;
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

  void refreshUID({bool? listen}) {
    uid = FirebaseAuth.instance.currentUser!.uid;
    if (listen == null || listen == true) {
      notifyListeners();
    }
  }

  void refreshIdToken({bool? listen}) async {
    idToken = (await FirebaseAuth.instance.currentUser!.getIdToken())!;
    if (listen == null || listen == true) {
      notifyListeners();
    }
  }

  void updatePoints(int newPoints) {
    points = newPoints;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    refreshUID(listen: false);
    refreshIdToken(listen: true);

    // var res = await APICalls().getUserDataAPI(uid, idToken);
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
      updateProfilePhoto(res['photoUrl']);
      updatePoints(res['points']);
      notifyListeners();
    }
    return {
      'success': res['success'],
      'message': res['message'],
    };
  }

  Future<Map<String, dynamic>> doATransaction(String to, int amount) async {
    refreshUID(listen: false);
    var response = await APICalls().transactionAPI(uid, to, amount);
    print("Response from provider-> $response");
    if (response['success']) {
      notifyListeners();
    }
    return response;
  }

  Future<Map<String, dynamic>> getLatest2Transactions() async {
    var res = await getUserTransactions();
    res['transactions'] = transactions.sublist(0, 2);
    return res;
  }

  Future<Map<String, dynamic>> getUserTransactions() async {
    refreshIdToken(listen: false);
    var res = await APICalls().getAllTransactions(idToken, uid);
    // print("res: ${res['transactions']}");
    if (res['success']) {
      if (res['transactions'].isNotEmpty) {
        for (var txn in res['transactions']) {
          DateTime utcTime = DateTime.parse(txn['updatedAt']).toLocal();
          String formattedTime =
              DateFormat("MMMM d, yyyy 'at' h:mm a").format(utcTime);
          if (txn['from'] == uid) {
            transactions.add(TransactionsWidget(
              name: txn['to'],
              date: formattedTime,
              type: 'debit',
              points: txn['transactionValue'],
            ));
          } else if (txn['to'] == uid) {
            transactions.add(TransactionsWidget(
              name: txn['to'],
              date: formattedTime,
              type: 'credit',
              points: txn['transactionValue'],
            ));
          }
        }
        notifyListeners();
      }
      return {
        'success': res['success'],
        'message': res['message'],
      };
    }
    return {
      'success': res['success'],
      'error': res['error'],
    };
  }
}
