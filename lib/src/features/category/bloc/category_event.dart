import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  CategoryEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchCategory extends CategoryEvent {}

class FetchCategoryByStore extends CategoryEvent {
  final String storeId;
  FetchCategoryByStore({required this.storeId});
}

class ChangeIndex extends CategoryEvent {
  final int index;
  ChangeIndex({required this.index});
}
