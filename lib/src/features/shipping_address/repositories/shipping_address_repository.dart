import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/shipping_address/models/address.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';
import 'package:lady_skin/src/utils/services/invalid_token_exception.dart';

class ShippingAddressRepository {
  ApiProvider apiProvider = ApiProvider();
  Future<void> setDefaultAddresses({required String addressId}) async {
    String url = "${dotenv.env['baseUrl']}/profile/location/$addressId";

    try {
      Response response = (await apiProvider.post(url, null, null))!;

      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      }
      // else if (response.data["code"] != 0) {
      //   throw CustomException(message: response.data["message"]);
      // }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<Address>> getUserAddresses() async {
    String url = "${dotenv.env['baseUrl']}/profile/location";

    try {
      Response response = (await apiProvider.get(url, "", null))!;
      List<Address> addressList = [];

      print(url);
      print(ApiProvider.accessToken);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        response.data["data"].forEach((address) {
          addressList.add(Address.fromJson(address));
        });
        return addressList;
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

  Future<Address> addUserAddress(
      {required String name,
      required String lat,
      required String long,
      required String description}) async {
    String url = "${dotenv.env['baseUrl']}/profile/location/add";
    log("$lat, $long");
    try {
      Map body = {
        "name": name,
        "lat": lat,
        "long": long,
        "description": description
      };

      Response response = (await apiProvider.post(url, body, null))!;

      if (response.statusCode == 200 && response.data["code"] == 0) {
        return Address.fromJson(response.data["data"]);
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

  Future<void> removeUserAddress({required String addressId}) async {
    String url = "${dotenv.env['baseUrl']}/profile/location/delete/$addressId";
    try {
      Response response = (await apiProvider.delete(url, null))!;

      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
