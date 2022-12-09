import 'package:equatable/equatable.dart';

abstract class CategoryDetailEvent extends Equatable {
  CategoryDetailEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchCategoryDetail extends CategoryDetailEvent {
  final String categoryId;
  FetchCategoryDetail({required this.categoryId});
}
