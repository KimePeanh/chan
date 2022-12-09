import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/notification/models/my_notification.dart';

import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';

enum ProductsOption { ByDefault, ByNotification, BySubNotification, BySearch }

class NotificationRepository {
  ApiProvider apiProvider = ApiProvider();
  int rowPerPage = 10;
  Future<List<MyNotification>> getNotification({required int page}) async {
    try {
      String url =
          "${dotenv.env['baseUrl']}/notifications?row_per_page=10&page=$page";
      Response response = (await apiProvider.get(url, null, null))!;

      if (response.statusCode == 200) {
        List<MyNotification> notificationList = [];
        response.data["data"].forEach((data) {
          log(data.toString());
          notificationList.add(MyNotification.fromJson(data));
        });
        return notificationList;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
