import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/sub_category/models/sub_category.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';

enum ProductsOption { ByDefault, ByCategory, BySubCategory, BySearch }

class SubCategoryRepository {
  ApiProvider apiProvider = ApiProvider();
  int rowPerPage = 10;

  Future<List<SubCategory>> getSubCategory({
    required String categoryId,
  }) async {
    String url = "${dotenv.env['baseUrl']}/subcategories/$categoryId";
    try {
      Response response = (await apiProvider.get(url, null, null))!;

      if (response.statusCode == 200) {
        List<SubCategory> subCategory = [];
        if (response.data["data"] == null ||
            response.data["data"].length == 0) {
          return [];
        } else {
          response.data["data"].forEach((item) {
            subCategory.add(SubCategory.fromJson(item));
          });
          return subCategory;
        }
      }
      throw CustomException.generalException();
    } catch (e) {
      log(e.toString());
      throw e;
    }
  }
}
