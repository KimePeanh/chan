import 'package:equatable/equatable.dart';

abstract class BlogListingEvent extends Equatable {
  @override
  List<Object> get props => [];
  BlogListingEvent();
}

class InitializeBlogList extends BlogListingEvent {
  final arg;
  InitializeBlogList({this.arg});
}

class FetchBlogList extends BlogListingEvent {
  final arg;
  FetchBlogList({required this.arg});
}
