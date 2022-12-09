import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/blog/models/blog.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';

class BlogDetailRepository {
  ApiProvider apiProvider = ApiProvider();
  Future<Blog> getBlog({required String blogId}) async {
    String url = "${dotenv.env['baseUrl']}/blog/$blogId";
    try {
      Response response = (await apiProvider.get(url, null, null))!;
      return Blog.fromJson(response.data["data"]);
    } catch (error) {
      throw error;
    }
  }
}
