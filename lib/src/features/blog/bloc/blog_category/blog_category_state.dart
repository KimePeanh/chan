import 'package:lady_skin/src/features/blog/models/blog_category.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class BlogCategoryState extends Equatable {
  BlogCategoryState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchingBlogCategory extends BlogCategoryState {
  @override
  String toString() => 'LoadingFavouriteProcessing';
}

class FetchedBlogCategory extends BlogCategoryState {
  @override
  String toString() => 'AddingFavouriteProcessing';
}

class ErrorFetchingBlogCategory extends BlogCategoryState {
  final String error;
  ErrorFetchingBlogCategory({required this.error});
  @override
  String toString() => 'LoadingFavouriteProcessing';
}

class FetchingBlogCategoryDetail extends BlogCategoryState {}

class FetchedBlogCategoryDetail extends BlogCategoryState {
  final BlogCategory blogCategory;
  FetchedBlogCategoryDetail({required this.blogCategory});
}

class ErrorFetchingBlogCategoryDetail extends BlogCategoryState {
  final String error;
  ErrorFetchingBlogCategoryDetail({required this.error});
}
