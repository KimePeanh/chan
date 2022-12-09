import 'package:equatable/equatable.dart';

abstract class StoreEvent extends Equatable {
  @override
  List<Object> get props => [];
  final bool isRefresh;
  StoreEvent({required this.isRefresh});
}

class FetchStarted extends StoreEvent {
  FetchStarted({this.isRefresh = false}) : super(isRefresh: isRefresh);

  final bool isRefresh;

  @override
  List<Object> get props => [isRefresh];
}

class FetchByCategoryStarted extends StoreEvent {
  FetchByCategoryStarted({this.isRefresh = false, required this.categoryId})
      : super(isRefresh: isRefresh);

  final bool isRefresh;
  final String categoryId;

  @override
  List<Object> get props => [isRefresh];
}

class FetchBySubCategoryStarted extends StoreEvent {
  FetchBySubCategoryStarted(
      {this.isRefresh = false, required this.subCategoryId})
      : super(isRefresh: isRefresh);

  final bool isRefresh;
  final String subCategoryId;

  @override
  List<Object> get props => [isRefresh];
}
