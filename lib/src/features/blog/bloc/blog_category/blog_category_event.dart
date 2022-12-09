import 'package:equatable/equatable.dart';

abstract class BlogCategoryEvent extends Equatable {
  BlogCategoryEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchBlogCategoryStarted extends BlogCategoryEvent {}

class FetchBlogCategoryDetail extends BlogCategoryEvent {
  final String blogCategoryId;
  FetchBlogCategoryDetail({required this.blogCategoryId});
}
