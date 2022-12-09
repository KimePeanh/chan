import 'package:equatable/equatable.dart';
import 'package:lady_skin/src/features/blog/models/blog_comment.dart';

abstract class BlogCommentEvent extends Equatable {
  BlogCommentEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class InitializeCommentList extends BlogCommentEvent {}

class FetchCommentList extends BlogCommentEvent {}

class AddComment extends BlogCommentEvent {
  final String text;
  AddComment({required this.text});
}

class EditComment extends BlogCommentEvent {
  final BlogComment blogComment;
  final String text;
  EditComment({required this.blogComment, required this.text});
}

class DeleteComment extends BlogCommentEvent {
  final BlogComment comment;
  DeleteComment({required this.comment});
}
