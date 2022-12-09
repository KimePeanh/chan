import 'package:equatable/equatable.dart';

abstract class ProductListingEvent extends Equatable {
  @override
  List<Object> get props => [];
  ProductListingEvent();
}

class InitializeProductList extends ProductListingEvent {
  final arg;
  InitializeProductList({this.arg});
}

class FetchProductList extends ProductListingEvent {
  final arg;
  FetchProductList({required this.arg});
}
