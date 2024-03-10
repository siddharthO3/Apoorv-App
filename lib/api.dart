// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

  Future<Map<String, dynamic>> uploadUserData(
    Map<String, dynamic> args,
    String idToken,
  ) async {
    Map<String, dynamic> payload = {};
    try {
      var response = await BaseClient.dio.post(
        '/user',
        data: jsonEncode(args),
        options: Options(
          headers: {'Authorization': idToken},
        ),
      );

      if (response.statusCode == 201) {
        print("Data uploadad in db");
        var res = json.decode(response.toString());
        payload['success'] = true;
        payload['message'] = res['message'];
      }
    } on DioException catch (e) {
      print(e);

      if (e.type == DioExceptionType.badResponse) {
        var res = json.decode(e.response.toString());
        payload['success'] = false;
        payload['message'] = res['error'];
      } else if (e.type == DioExceptionType.connectionError) {
        payload['success'] = false;
        payload['error'] = "Connection Error, please retry later";
      } else {
        payload['success'] = false;
        payload['error'] = "Unknown Error, ${e.type.name}";
      }
    }
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
        payload = json.decode(response.toString()) as Map<String, dynamic>;
        payload['message'] = 'User data updated for transaction';
      }
      if (response.statusCode == 204) {
        payload['transactions'] = [];
        payload['success'] = true;
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
    } catch (e) {
      print("Error: $e");
      // Handle other exceptions appropriately
      payload['success'] = false;
      payload['error'] = e.toString();
    }
    return payload;
  }

  Future<Map<String, dynamic>> transactionAPI(
    String from,
    String to,
    int amount,
    // String idToken,
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
        // options: Options(
        //   headers: {
        //     'Authorization': idToken,
        //   },
        // ),
      );
      print("Response in api call:$response");

      res = json.decode(response.toString());
      print(res);

      retValue = {
        'success': true,
        'message': 'Transaction completed successfully!',
      };
    } on DioException catch (e) {
      print(e);

      if (e.type == DioExceptionType.badResponse) {
        print(e);
        print(e.response!);
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

  Future<Map<String, dynamic>> getLeaderboard(String idToken) async {
    Map<String, dynamic> payload = {};
    try {
      var response = await BaseClient.dio.get(
        '/user-list/?sort=points&order=-1',
        options: Options(
          headers: {
            'Authorization': idToken,
          },
        ),
      );

      print("Transaction Query: $response");

      if (response.statusCode == 200) {
        payload =
            json.decode(response.toString()) as Map<String, dynamic>;
        payload['message'] = 'User data updated for transaction';
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        print("Response code: ${e.response!.statusCode}");
        payload['error'] =
            "${json.decode(e.response.toString())['error']}\n${e.type.name}, ${e.response!.statusCode}";
      } else if (e.type == DioExceptionType.connectionError) {
        payload['error'] = "${e.type.name} Connection Error";
      } else {
        payload['error'] =
            "${json.decode(e.response.toString())['error']}\n${e.type.name}, ${e.response!.statusCode}";
      }
    } catch (e) {
      print("Error: $e");
      // Handle other exceptions appropriately
      payload['success'] = false;
      payload['error'] = e.toString();
    }
    return payload;
  }
}
