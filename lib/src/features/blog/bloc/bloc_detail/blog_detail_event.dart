import 'package:equatable/equatable.dart';

abstract class BlogDetailEvent extends Equatable {
  BlogDetailEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchBlogDetail extends BlogDetailEvent {
  final String blogId;
  FetchBlogDetail({required this.blogId});
}
