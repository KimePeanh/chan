import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'custom_exception.dart';

enum Method { Post, Get, Delete, Put }

class ApiProvider {
  static String accessToken = '';
  Dio _dio = Dio();

  Future<Response?> post(String url, dynamic body, Options? options) async {
    return _httpServices(
        method: Method.Post, url: url, body: body, options: options);
  }

  Future<Response?> get(String url, dynamic body, Options? options) async {
    return _httpServices(
        method: Method.Get, url: url, body: body, options: options);
  }

  Future<Response?> put(String url, dynamic body) async {
    return _httpServices(method: Method.Put, url: url, body: body);
  }

  Future<Response?> delete(String url, dynamic body) async {
    return _httpServices(method: Method.Delete, url: url, body: body);
  }

  Future<Response?> _httpServices(
      {required Method method,
      required String url,
      dynamic body,
      Options? options}) async {
    //print(options.headers.toString());
    Response response;
    try {
      _dio.options.headers["token"] = accessToken;
      _dio.options.headers["Authorization"] = "Bearer $accessToken";
      _dio.options.headers["type"] = "upload";
      _dio.options.headers["Accept"] = "application/json";
      response = await ((method == Method.Post)
          ? _dio.post(url, data: body, options: options)
          : (method == Method.Get)
              ? _dio.get(url, options: options)
              : (method == Method.Put)
                  ? _dio.put(url, data: body)
                  : _dio.delete(url, data: body));
    } on DioError catch (e) {
      log(e.response.toString());
      if (e.type == DioErrorType.response) {
        if (e.response!.statusCode == 401) {
          throw 401;
        } else {
          throw e.message;
        }
      }

      throw CustomException.noInternet();
    }
    print(response.data);
    Map<String, dynamic> data = {};
    if (response.data.runtimeType == (data.runtimeType)) {
      data = response.data;
    }
    if (data.containsKey("code") && data.containsKey("message")) {
      if (data.containsKey("quantity")) {
      } else {
        String code = "${data["code"]}";
        if (code == "0") {
          return response;
        } else {
          throw data["message"].toString();
        }
      }
    }
    return response;
  }
}

Future<String> uploadImage({required File image}) async {
  try {
    Dio _dio = Dio();
    _dio.options.headers["Authorization"] = "anakut";
    _dio.options.headers["type"] = "upload";
    _dio.options.headers["Authorization"] = "Bearer ${ApiProvider.accessToken}";
    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(image.path, filename: fileName),
    });
    Response response =
        await _dio.post("${dotenv.env['baseUrl']}/upload", data: formData);

    if (response.statusCode == 200 && response.data["code"].toString() == "0") {
      return response.data["image_url"];
    } else if (response.data["code"].toString() != "0") {
      throw CustomException(message: response.data["message"]);
    } else {
      throw CustomException.generalException();
    }
  } catch (e) {
    print(e);
    throw "gdgdg";
  }
}
