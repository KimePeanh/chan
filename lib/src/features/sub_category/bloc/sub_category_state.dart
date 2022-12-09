import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class SubCategoryState extends Equatable {
  SubCategoryState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchingSubCategory extends SubCategoryState {
  @override
  String toString() => 'LoadingFavouriteProcessing';
}

class FetchedSubCategory extends SubCategoryState {
  @override
  String toString() => 'AddingFavouriteProcessing';
}

class ErrorFetchingSubCategory extends SubCategoryState {
  final String error;
  ErrorFetchingSubCategory({required this.error});
  @override
  String toString() => 'LoadingFavouriteProcessing';
}
