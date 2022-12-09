import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/my_order/models/my_order.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';
import 'package:lady_skin/src/utils/services/invalid_token_exception.dart';

abstract class OrderRepository {
  final ApiProvider apiProvider = ApiProvider();
  final String baseUrl = "${dotenv.env['baseUrl']}/checkout/history?status=";
  String url = "";
  Future<List<MyOrder>> getOrderList();
  Future<List<MyOrder>> getOrderListG({required String urlSuffix}) async {
    try {
      url = baseUrl + urlSuffix;
      Response response = (await apiProvider.get(url, null, null))!;

      if (response.statusCode == 200) {
        List<MyOrder> orderList = [];
        response.data["data"].forEach((val) {
          orderList.add(MyOrder.fromJson(val));
        });
        return orderList;
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}

class OrderByPendingRepo extends OrderRepository {
  @override
  Future<List<MyOrder>> getOrderList() async =>
      await super.getOrderListG(urlSuffix: "pending");
}

class OrderByPaidRepo extends OrderRepository {
  @override
  Future<List<MyOrder>> getOrderList() async {
    return await super.getOrderListG(urlSuffix: "paid");
  }
}

class OrderByOnDeliveryRepo extends OrderRepository {
  @override
  Future<List<MyOrder>> getOrderList() async {
    return await super.getOrderListG(urlSuffix: "ondelivery");
  }
}

class OrderByCompletedRepo extends OrderRepository {
  @override
  Future<List<MyOrder>> getOrderList() async {
    return await super.getOrderListG(urlSuffix: "completed");
  }
}

Future<MyOrderDetail> getOrderDetail({required String orderId}) async {
  try {
    ApiProvider apiProvider = ApiProvider();
    Response response = (await apiProvider.get(
        "${dotenv.env['baseUrl']}/checkout/history/detail/$orderId",
        null,
        null))!;

    if (response.statusCode == 200 && response.data["code"] == 0) {
      return MyOrderDetail.fromJson(response.data);
    } else if (response.statusCode == 401) {
      throw InvalidTokenException();
    } else if (response.data["code"] != 0) {
      throw CustomException(message: response.data["message"]);
    }
    throw CustomException.generalException();
  } catch (e) {
    throw e;
  }
}

Future<void> payOrder(
    {required String paymentMethod,
    required String imageUrl,
    required String orderId}) async {
  ApiProvider apiProvider = ApiProvider();
  String url = "${dotenv.env['baseUrl']}/payment/transfer/$orderId";
  Map body = {
    "payment_type": "transfer",
    "payment_method": paymentMethod.startsWith("P") ? "Phone" : paymentMethod,
    "image_url": imageUrl
  };

  try {
    Response response = (await apiProvider.post(url, body, null))!;

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      throw InvalidTokenException();
    } else {
      throw CustomException(message: "Unknow error accured");
    }
  } catch (e) {
    throw e;
  }
}
