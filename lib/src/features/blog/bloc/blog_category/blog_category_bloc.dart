import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/blog/models/blog_category.dart';
import 'package:lady_skin/src/features/blog/repositories/blog_category_repository.dart';

import 'blog_category_event.dart';
import 'blog_category_state.dart';

class BlogCategoryBloc extends Bloc<BlogCategoryEvent, BlogCategoryState> {
  List<BlogCategory> blogCategoryList = [];
  BlogCategoryRepository _blogCategoryRepository = BlogCategoryRepository();
  @override
  BlogCategoryBloc() : super(FetchingBlogCategory());

  @override
  Stream<BlogCategoryState> mapEventToState(BlogCategoryEvent event) async* {
    if (event is FetchBlogCategoryStarted) {
      yield FetchingBlogCategory();
      try {
        await Future.delayed(Duration(milliseconds: 1000));
        List<BlogCategory> temp = [];
        temp = await _blogCategoryRepository.getBlogCategory();
        blogCategoryList.addAll(temp);
        yield FetchedBlogCategory();
      } catch (e) {
        yield ErrorFetchingBlogCategory(error: e.toString());
      }
    }
    if (event is FetchBlogCategoryDetail) {
      yield FetchingBlogCategoryDetail();
      try {
        final BlogCategory blogCategory = await _blogCategoryRepository
            .getBlogCategoryDetail(blogCategoryId: event.blogCategoryId);

        yield FetchedBlogCategoryDetail(blogCategory: blogCategory);
      } catch (e) {
        yield ErrorFetchingBlogCategoryDetail(error: e.toString());
      }
    }
  }
}
