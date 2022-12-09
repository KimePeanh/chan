import 'package:lady_skin/src/features/category/models/category.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CategoryDetailState extends Equatable {
  CategoryDetailState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchingCategoryDetail extends CategoryDetailState {}

class FetchedCategoryDetail extends CategoryDetailState {
  final Category category;
  FetchedCategoryDetail({required this.category});
}

class ErrorFetchingCategoryDetail extends CategoryDetailState {
  final String error;
  ErrorFetchingCategoryDetail({required this.error});
}
