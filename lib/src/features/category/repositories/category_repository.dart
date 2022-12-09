import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/category/models/category.dart';
import 'package:lady_skin/src/features/category/models/category_content.dart';
import 'package:lady_skin/src/features/sub_category/models/sub_category.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';

enum ProductsOption { ByDefault, ByCategory, BySubCategory, BySearch }

class CategoryRepository {
  ApiProvider apiProvider = ApiProvider();
  int rowPerPage = 10;
  Future<List<Category>> getCategory() async {
    try {
      String url = "${dotenv.env['baseUrl']}/categories";
      Response response = (await apiProvider.get(url, null, null))!;

      if (response.statusCode == 200) {
        List<Category> category = [];
        response.data["data"].forEach((data) {
          category.add(Category.fromJson(data));
        });
        return category;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<Category>> getCategoryByStore({required String storeId}) async {
    try {
      String url =
          "http://ecommerceapi.anakutapp.com/stores/categories/store_id=$storeId";
      Response response = (await apiProvider.get(url, null, null))!;

      if (response.statusCode == 200) {
        List<Category> category = [];
        response.data["data"].forEach((data) {
          category.add(Category.fromJson(data));
        });
        return category;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<CategoryContent> getCategoryContent({
    required String categoryId,
  }) async {
    try {
      String url =
          "http://ecommerceapi.anakutapp.com/model_ecommerce/features/category_id=$categoryId";
      Response response = (await apiProvider.get(url, null, null))!;

      if (response.statusCode == 200) {
        return CategoryContent.fromJson(response.data);
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

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
      throw e;
    }
  }
}
