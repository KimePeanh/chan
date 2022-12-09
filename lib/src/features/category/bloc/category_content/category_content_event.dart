import 'package:equatable/equatable.dart';

abstract class CategoryContentEvent extends Equatable {
  CategoryContentEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchCategoryContent extends CategoryContentEvent {
  final String categoryId;
  FetchCategoryContent({required this.categoryId});
  @override
  List<Object> get props => [];
}
