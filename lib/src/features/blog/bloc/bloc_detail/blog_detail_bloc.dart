import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/blog/models/blog.dart';
import 'package:lady_skin/src/features/blog/repositories/blog_detail_repository.dart';

import 'blog_detail_event.dart';
import 'blog_detail_state.dart';

class BlogDetailBloc extends Bloc<BlogDetailEvent, BlogDetailState> {
  BlogDetailRepository _blogDetailRepository = BlogDetailRepository();
  @override
  BlogDetailBloc() : super(FetchingBlogDetail());

  @override
  Stream<BlogDetailState> mapEventToState(BlogDetailEvent event) async* {
    if (event is FetchBlogDetail) {
      yield FetchingBlogDetail();
      try {
        final Blog blog =
            await _blogDetailRepository.getBlog(blogId: event.blogId);

        yield FetchedBlogDetail(blog: blog);
      } catch (e) {
        yield ErrorFetchingBlogDetail(error: e.toString());
      }
    }
  }
}
