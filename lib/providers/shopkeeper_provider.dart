import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api.dart';
import '../widgets/points-widget/transactions.dart';

class ShopkeeperProvider extends ChangeNotifier {
  String shopkeeperEmail;
  String shopkeeperPassword;
  String profilePhoto;
  int shopPoints = 0;
  List<dynamic> pointsArray = [];
  String idToken;
  String uid;
  String name;

  List<TransactionsWidget> transactions = [];

  ShopkeeperProvider({
    this.name = "",
    this.shopkeeperEmail = " ",
    this.profilePhoto =
        "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
    this.shopkeeperPassword = " ",
    this.idToken = " ",
    this.uid = " ",
  });

  void updateShopkeeper({
    required String shopEmail,
    required String shopPass,
  }) {
    shopkeeperEmail = shopEmail;
    shopkeeperPassword = shopPass;
    notifyListeners();
  }

  void updateProfilePhoto(String pf) {
    profilePhoto = pf;
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

  void updateEmail(String em) {
    shopkeeperEmail = em;
    notifyListeners();
  }

  void refreshGoogleServiceData() async {
    refreshUID();
    refreshIdToken();
    updateEmail(FirebaseAuth.instance.currentUser!.email!);
    updateProfilePhoto(FirebaseAuth.instance.currentUser!.photoURL!);
  }

  void updatePoints(int newPoints) {
    shopPoints = newPoints;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    refreshUID(listen: false);
    print(uid);
    refreshIdToken(listen: true);

    var args = {
      "from": uid,
      "password": shopkeeperPassword,
      "email": shopkeeperEmail,
    };

    var res = await APICalls().getUserDataAPI(uid, idToken, args: args);
    print("res get user api: $res");
    if (res['success']) {
      updateEmail(res['email']);
      pointsArray = res['pointsArray'];
      name = res['fullName'];
      updatePoints(res['points']);
      notifyListeners();
    }
    return res;
  }

  Future<Map<String, dynamic>> getLatest2Transactions() async {
    var res = await getUserTransactions();
    if (transactions.isNotEmpty) {
      res['transactions'] =
          transactions.sublist(0, min(2, transactions.length));
    }
    return res;
  }

  Future<Map<String, dynamic>> getUserTransactions() async {
    refreshIdToken(listen: false);
    var res = await APICalls().getAllTransactions(idToken, uid);
    // print(res['success']);
    if (res['success']) {
      transactions.clear();
      if (res['transactions'].isNotEmpty) {
        for (var txn in res['transactions']) {
          DateTime utcTime = DateTime.parse(txn['updatedAt']).toLocal();
          String formattedTime =
              DateFormat("MMMM d, yyyy 'at' h:mm a").format(utcTime);
          if (txn['from'] == uid) {
            transactions.add(TransactionsWidget(
              name: txn['toName'],
              date: formattedTime,
              type: 'debit',
              points: txn['transactionValue'],
            ));
          } else if (txn['to'] == uid) {
            transactions.add(TransactionsWidget(
              name: txn['fromName'],
              date: formattedTime,
              type: 'credit',
              points: txn['transactionValue'],
            ));
          }
        }
      }
      notifyListeners();
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
