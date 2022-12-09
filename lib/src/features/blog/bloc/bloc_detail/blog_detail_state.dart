import 'package:lady_skin/src/features/blog/models/blog.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class BlogDetailState extends Equatable {
  BlogDetailState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchingBlogDetail extends BlogDetailState {}

class FetchedBlogDetail extends BlogDetailState {
  final Blog blog;
  FetchedBlogDetail({required this.blog});
}

class ErrorFetchingBlogDetail extends BlogDetailState {
  final String error;
  ErrorFetchingBlogDetail({required this.error});
}
