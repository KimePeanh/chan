import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
  final bool isRefresh;
  ProductEvent({required this.isRefresh});
}

class FetchStarted extends ProductEvent {
  FetchStarted({this.isRefresh = false}) : super(isRefresh: isRefresh);

  final bool isRefresh;

  @override
  List<Object> get props => [isRefresh];
}

class FetchByCategoryStarted extends ProductEvent {
  FetchByCategoryStarted({this.isRefresh = false, required this.categoryId})
      : super(isRefresh: isRefresh);

  final bool isRefresh;
  final String categoryId;

  @override
  List<Object> get props => [isRefresh];
}

class FetchByStoreCategoryStarted extends ProductEvent {
  FetchByStoreCategoryStarted(
      {this.isRefresh = false, required this.categoryId, required this.storeId})
      : super(isRefresh: isRefresh);

  final bool isRefresh;
  final String categoryId;
  final String storeId;

  @override
  List<Object> get props => [isRefresh];
}

class FetchBySubCategoryStarted extends ProductEvent {
  FetchBySubCategoryStarted(
      {this.isRefresh = false, required this.subCategoryId})
      : super(isRefresh: isRefresh);

  final bool isRefresh;
  final String subCategoryId;

  @override
  List<Object> get props => [isRefresh];
}
