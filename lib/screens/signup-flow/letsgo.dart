import 'dart:convert';

import 'package:apoorv_app/base_client.dart';
import 'package:apoorv_app/providers/user_info_provider.dart';
import 'package:apoorv_app/screens/homepage/homepage.dart';
import 'package:apoorv_app/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

// TODO: Fix Let's go page and move API
class LetsGoPage extends StatelessWidget {
  static const routeName = "/letsgo";
  LetsGoPage({super.key});

  late Map<String, dynamic> args;

  Future<List> uploadNewUserData(
      Map<String, dynamic> args, String idToken) async {
    var data = jsonEncode(args);
    List<Object> ret = [];
    try {
      // var response = await Dio().post('http://10.0.2.2:3000/api/v1/user',
      //     data: data, options: Options(headers: {'Authorization': idToken}));
      var response = await BaseClient.dio.post('/user',
          data: data, options: Options(headers: {'Authorization': idToken}));

      if (response.statusCode == 201) {
        print("Data uploaded in the db: $data");
        ret = [true, 'Data uploaded in the db'];
      }
    } on DioException catch (e) {
      // print("Message: ${e.message}");
      // print("Response code: ${e.response!.statusCode}");

      // TODO: Custom error messages needed

      if (e.type == DioExceptionType.badResponse) {
        ret = [
          false,
          "${e.type.name}, index: ${e.type.index}: ${e.response!.statusCode}"
        ];
      } else if (e.type == DioExceptionType.connectionError) {
        // return [false, "Error code: ${e.response!.statusCode}, with index: ${e.type.name}"];
        ret = [false, "${e.type.name}, index: ${e.type.index}"];
      }

      // if (response.statusCode == 409) {
      //   print("User already exists");
      //   return false;
      // } else {
      //   print(
      //       "Unable to upload data: ${response.statusCode} -> ${response.statusMessage}");
      //   return false;
      // }
      else {
        ret = [false, "Unhandled/Unknown Error, with name: ${e.type.name}"];
      }
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    // args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // Provider.of<UserProvider>(context, listen: false).refreshIdToken();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/people_800.png'),
            const Text(
              "Let's Explore The \nApp",
              style: TextStyle(
                  fontSize: 36,
                  color: Constants.yellowColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Text(
                "Lorem ipsum dolor sit amet consectetur. A gravida eros aliquam sed condimentum. Etiam vitae sit scelerisque a eget integer. Quis in dolor amet velit pretium sed vestibulum. Urna ullamcorper eu egestas egestas amet id.",
                textAlign: TextAlign.center),
            FilledButton(
              onPressed: () async {
                Navigator.of(context).restorablePushNamedAndRemoveUntil(
                    HomePage.routeName, (route) => false);
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Constants.redColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: Container(
                height: 48,
                alignment: Alignment.center,
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
