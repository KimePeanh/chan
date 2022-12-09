import 'package:equatable/equatable.dart';

abstract class BlogListingState extends Equatable {
  const BlogListingState();

  @override
  List<Object> get props => [];
}

class InitializingBlogList extends BlogListingState {}

class InitializedBlogList extends BlogListingState {}

class FetchingBlogList extends BlogListingState {}

class FetchedBlogList extends BlogListingState {}

class EndOfBlogList extends BlogListingState {}

class ErrorFetchingBlogList extends BlogListingState {
  final String error;
  ErrorFetchingBlogList({required this.error});
  @override
  String toString() => 'LoadingFavourite';
}

class ErrorInitializingBlogList extends BlogListingState {
  final String error;
  ErrorInitializingBlogList({required this.error});
  @override
  String toString() => 'LoadingFavourite';
}
