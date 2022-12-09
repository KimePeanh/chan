import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';

class LoginRegisterRepository {
  ApiProvider apiProvider = ApiProvider();

  Future<String> login(
      {required String phone, required String password}) async {
    String url = "${dotenv.env['baseUrl']}/login";
    String body = '{"phone":"$phone","password":"$password"}';
    var auth = 'Basic ' + base64Encode(utf8.encode('$phone:$password'));
    try {
      Response response = (await apiProvider.post(url, body,
          Options(headers: <String, String>{'authorization': auth})))!;
      if (response.statusCode == 200 && response.data["code"] == 0) {
        if (response.data["token"] == null) {
          throw CustomException.signInException(statusCode: 1);
        }
        return response.data["token"];
      }
      throw CustomException.signInException(statusCode: 1);
    } catch (error) {
      throw error;
    }
  }

  Future<String> register(
      {
      // required String firstName,
      // required String lastName,
      required String name,
      required String phone,
      required String password}) async {
    await Future.delayed(Duration(seconds: 1));
    String url = '${dotenv.env['baseUrl']}/register';
    String body =
        '{"name": "$name","phone":"$phone","password":"$password","email": ""}';
    try {
      Response response = (await apiProvider.post(url, body, null))!;

      if (response.statusCode == 200) {
        if (response.data["token"] == null) {
          throw CustomException(message: response.data["message"]);
        }
        return response.data["token"];
      }
      throw CustomException.registerException(statusCode: response.statusCode!);
    } catch (error) {
      throw error;
    }
  }
}
