import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/product/models/product.dart';
import 'package:lady_skin/src/shared/widgets/error_snackbar.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';
import 'package:lady_skin/src/utils/services/storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchRepository {
  ApiProvider apiProvider = ApiProvider();
  Storage storage = Storage();
  Future<List<Product>> searchProduct(
      {required int page,
      required String query,
      required bool isAuthenticated}) async {
    String urlSuffix = "/products?page=1&row_per_page=10&name=$query";
    String url =
        dotenv.env['baseUrl']! + (isAuthenticated ? "/auth" : "") + urlSuffix;
    try {
      // Fluttertoast.showToast(msg: "$url");
      // Response response = (await apiProvider.get(url, null, null))!;
      // print(url);
      // if (response.statusCode == 200) {
      //   //  errorSnackBar(
      //   //       text: ""
      //   //       context: context);
      //   // Fluttertoast.showToast(msg: "$url");

      //   List<Product> products = [];
      //   response.data["data"].forEach((val) {
      //     products.add(Product.fromJson(val));
      //   });

      //   return products;
      // }
      // throw CustomException.generalException();
      if (isAuthenticated) {
        Response response = (await apiProvider.get(
            "${dotenv.env['baseUrl']!}/auth/products?page=1&row_per_page=10&name=$query",
            null,
            null))!;
        if (response.statusCode == 200) {
          List<Product> products = [];
          response.data["data"].forEach((val) {
            products.add(Product.fromJson(val));
          });

          return products;
        }
        throw CustomException.generalException();
      } else {
        Response response = (await apiProvider.get(
            "${dotenv.env['baseUrl']!}/products?page=1&row_per_page=10&name=$query",
            null,
            null))!;
        if (response.statusCode == 200) {
          //  errorSnackBar(
          //       text: ""
          //       context: context);
          // Fluttertoast.showToast(msg: "$url");

          List<Product> products = [];
          response.data["data"].forEach((val) {
            products.add(Product.fromJson(val));
          });

          return products;
        }
        throw CustomException.generalException();
      }
    } catch (e) {
      throw e;
    }
  }

  getHistory() {}

  // Future<List<String>> getHistory() async {
  //   String searchHistory = await storage.getSearchHistory();

  //   if (searchHistory == null) {
  //     return [];
  //   }
  //   return Helper.convertStringtoListString(data: searchHistory);
  // }
}
