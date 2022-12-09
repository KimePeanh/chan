import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/blog/models/blog_comment.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';

class BlogCommentRepository {
  Future<List<BlogComment>> getComment(
      {required String blogId, required int page}) async {
    String url =
        "${dotenv.env['baseUrl']}/blog_comments/$blogId?row_per_page=10&page=$page";
    ApiProvider apiProvider = ApiProvider();
    try {
      Response response = (await apiProvider.get(url, null, null))!;
      log(response.data.toString());
      List<BlogComment> blogcommentList = [];
      response.data["data"].forEach((comment) {
        blogcommentList.add(BlogComment.fromJson(comment));
      });

      return blogcommentList;
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<BlogComment> addComment(
      {required String blogId, required String text}) async {
    String url = "${dotenv.env['baseUrl']}/blog_comments/add";
    ApiProvider apiProvider = ApiProvider();
    try {
      Map body = {"blog_id": "$blogId", "message": "$text"};
      Response response = (await apiProvider.post(url, body, null))!;
      print(response.data);

      return BlogComment.fromJson(response.data["data"]);
    } catch (error) {
      throw error;
    }
  }

  Future<BlogComment> editComment(
      {required String commentId, required String text}) async {
    String url = "${dotenv.env['baseUrl']}/blog_comments/edit/$commentId";
    ApiProvider apiProvider = ApiProvider();
    try {
      Map body = {"message": "$text"};
      Response response = (await apiProvider.put(url, body))!;
      print(response.data);
      return BlogComment.fromJson(response.data["data"]);
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteComment({required String commentId}) async {
    String url = "${dotenv.env['baseUrl']}/blog_comments/remove/$commentId";
    ApiProvider apiProvider = ApiProvider();
    try {
      Response response = (await apiProvider.delete(url, null))!;
      print(response.data);
      return;
    } catch (error) {
      throw error;
    }
  }
}
