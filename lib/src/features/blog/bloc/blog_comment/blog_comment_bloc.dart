import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/blog/models/blog_comment.dart';
import 'package:lady_skin/src/features/blog/repositories/blog_comment_repository.dart';

import 'blog_comment_event.dart';
import 'blog_comment_state.dart';

class BlogCommentBloc extends Bloc<BlogCommentEvent, BlogCommentState> {
  final String blogId;
  int page = 1;
  List<BlogComment> blogCommentList = [];
  bool isEndofList = false;
  BlogCommentRepository _blogCommentRepository = BlogCommentRepository();
  @override
  BlogCommentBloc({required this.blogId}) : super(InitializingCommentList());

  @override
  Stream<BlogCommentState> mapEventToState(BlogCommentEvent event) async* {
    if (event is InitializeCommentList) {
      yield InitializingCommentList();
      try {
        page = 1;
        List<BlogComment> temp = [];
        temp =
            await _blogCommentRepository.getComment(page: page, blogId: blogId);
        blogCommentList.clear();
        blogCommentList.addAll(temp);
        page++;
        yield FetchedCommentList();
      } catch (e) {
        yield ErrorFetchingCommentList(error: e);
      }
    }
    if (event is FetchCommentList) {
      yield FetchingCommentList();
      try {
        List<BlogComment> temp = [];
        temp =
            await _blogCommentRepository.getComment(page: page, blogId: blogId);
        if (temp.length == 0) {
          isEndofList = true;
        }
        blogCommentList.addAll(temp);
        page++;
        yield FetchedCommentList();
      } catch (e) {
        yield ErrorFetchingCommentList(error: e);
      }
    }
    if (event is AddComment) {
      yield ProcessingComment();
      try {
        BlogComment comment = await _blogCommentRepository.addComment(
            blogId: blogId, text: event.text);

        blogCommentList.add(comment);
        // await Future.delayed(Duration(milliseconds: 500));

        yield ProcessedComment();
        await Future.delayed(Duration(milliseconds: 500));
        yield AddedComment();
      } catch (e) {
        yield ErrorProcessingComment(error: e);
      }
    }
    if (event is EditComment) {
      yield ProcessingComment();
      try {
        BlogComment comment = await _blogCommentRepository.editComment(
            commentId: event.blogComment.id, text: event.text);
        int i = blogCommentList.indexOf(event.blogComment);
        blogCommentList[i] = comment;
        // blogCommentList[i].text=
        // blogCommentList.add()
        yield ProcessedComment();
      } catch (e) {
        yield ErrorProcessingComment(error: e);
      }
    }
    if (event is DeleteComment) {
      yield ProcessingComment();
      try {
        await _blogCommentRepository.deleteComment(commentId: event.comment.id);
        blogCommentList.remove(event.comment);
        yield ProcessedComment();
      } catch (e) {
        yield ErrorProcessingComment(error: e);
      }
    }
  }
}
