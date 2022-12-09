import 'package:equatable/equatable.dart';

abstract class SubCategoryEvent extends Equatable {
  SubCategoryEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchSubCategoryStarted extends SubCategoryEvent {
  final String categoryId;
  FetchSubCategoryStarted({required this.categoryId});
  @override
  List<Object> get props => [];
}
