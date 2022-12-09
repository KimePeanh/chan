import 'package:equatable/equatable.dart';

abstract class ProductListingState extends Equatable {
  const ProductListingState();

  @override
  List<Object> get props => [];
}

class InitializingProductList extends ProductListingState {}

class InitializedProductList extends ProductListingState {}

class FetchingProductList extends ProductListingState {}

class FetchedProductList extends ProductListingState {}

class EndOfProductList extends ProductListingState {}

class ErrorFetchingProductList extends ProductListingState {
  final String error;
  ErrorFetchingProductList({required this.error});
  @override
  String toString() => 'LoadingFavourite';
}

class ErrorInitializingProductList extends ProductListingState {
  final String error;
  ErrorInitializingProductList({required this.error});
  @override
  String toString() => 'LoadingFavourite';
}
