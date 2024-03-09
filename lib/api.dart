// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';

import 'base_client.dart';

class APICalls {
  Future<Map<String, dynamic>> getUserDataAPI(
    String uid,
    String idToken,
  ) async {
    Map<String, dynamic> payload = {};
    try {
      var response = await BaseClient.dio.get(
        '/user/$uid',
        options: Options(
          headers: {
            'Authorization': idToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        payload =
            json.decode(response.toString())["user"] as Map<String, dynamic>;
        print(payload);
        payload['success'] = true;
        payload['message'] = 'User data updated for users';
      }
    } on DioException catch (e) {
      print("Response code: ${e.response!.statusCode}");
      print(e.message);
      // TODO: Custom error messages needed
      if (e.type == DioExceptionType.badResponse) {
        payload['message'] =
            "${e.type.name}, index: ${e.type.index}: ${e.response!.statusCode}";
      } else if (e.type == DioExceptionType.connectionError) {
        payload['message'] = "${e.type.name}, index: ${e.type.index}";
        // return [false, "Error code: ${e.response!.statusCode}, with index: ${e.type.name}"];
      } else {
        payload['message'] =
            "Unhandled/Unknown Error, with name: ${e.type.name}";
      }
      payload['success'] = false;
    }
    print(payload);
    return payload;
  }

  Future<Map<String, dynamic>> getAllTransactions(
    String idToken,
    String uid,
  ) async {
    Map<String, dynamic> payload = {};
    try {
      var response = await BaseClient.dio.get(
        '/transaction/$uid',
        options: Options(
          headers: {
            'Authorization': idToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        print("All transaction hit successful");
        payload = json.decode(response.toString()) as Map<String, dynamic>;
        payload['message'] = 'User data updated for transaction';
      }
      if (response.statusCode == 204) {
        payload['transactions'] = [];
        payload['message'] = payload['error'];
      }
    } on DioException catch (e) {
      print("Response code: ${e.response!.statusCode}");
      if (e.type == DioExceptionType.badResponse) {
        payload['error'] =
            "${json.decode(e.response.toString())['error']}\n${e.type.name}, index: ${e.type.index}: ${e.response!.statusCode}";
      } else if (e.type == DioExceptionType.connectionError) {
        payload['error'] =
            "${e.type.name}, index: ${e.type.index}: ${e.response!.statusCode}";
      } else {
        payload['error'] =
            "${json.decode(e.response.toString())['error']}\n${e.type.name}, index: ${e.type.index}: ${e.response!.statusCode}";
      }
    }
    return payload;
  }

  Future<Map<String, dynamic>> transactionAPI(
    String from,
    String to,
    int amount,
  ) async {
    var args = {
      "from": from,
      "to": to,
      "amount": amount,
      "transactionType": "user",
    };
    Map<String, dynamic> retValue = {};

    Map<String, dynamic> res = {};

    try {
      var response = await BaseClient.dio.post(
        '/transaction',
        data: jsonEncode(args),
      );
      print(response);

      res = json.decode(response.toString());
      print(res);

      retValue = {
        'success': true,
        'message': 'Transaction completed successfully!',
      };
    } on DioException catch (e) {
      print(e.type);
      print(e.message);

      if (e.type == DioExceptionType.badResponse) {
        retValue = {
          'success': false,
          'message':
              'Transaction didn"t complete!, ${e.type.name}\n${json.decode(e.response.toString())['error']}',
        };
      } else {
        retValue = {
          'success': false,
          'message': 'Transaction didn"t complete!, ${e.type.name}',
        };
      }
    }

    return retValue;
  }
}
