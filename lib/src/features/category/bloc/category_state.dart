import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CategoryState extends Equatable {
  CategoryState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchingCategory extends CategoryState {
  @override
  String toString() => 'LoadingFavouriteProcessing';
}

class FetchedCategory extends CategoryState {
  @override
  String toString() => 'AddingFavouriteProcessing';
}

class ErrorFetchingCategory extends CategoryState {
  final String error;
  ErrorFetchingCategory({required this.error});
  @override
  String toString() => 'LoadingFavouriteProcessing';
}

class ChangingIndex extends CategoryState {}

class ChangedIndex extends CategoryState {}
