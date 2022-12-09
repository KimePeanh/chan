import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/blog/models/blog_category.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';

class BlogCategoryRepository {
  ApiProvider apiProvider = ApiProvider();
  String baseUrl = "${dotenv.env['baseUrl']}/blog_categories";
  int rowPerPage = 10;
  Future<List<BlogCategory>> getBlogCategory() async {
    String url = baseUrl;
    try {
      Response response = (await apiProvider.get(url, null, null))!;

      if (response.statusCode == 200) {
        var data = response.data;
        List<BlogCategory> blogCategoryList = [];
        data["data"].forEach((blogCategory) {
          blogCategoryList.add(BlogCategory.fromJson(blogCategory));
        });
        return blogCategoryList;
      }
      throw CustomException.generalException();
    } catch (error) {
      throw error;
    }
  }

  Future<BlogCategory> getBlogCategoryDetail(
      {required String blogCategoryId}) async {
    String url = "${dotenv.env['baseUrl']}/blog_categories/$blogCategoryId";
    try {
      Response response = (await apiProvider.get(url, null, null))!;
      return BlogCategory.fromJson(response.data["data"]);
    } catch (error) {
      throw error;
    }
  }
}
