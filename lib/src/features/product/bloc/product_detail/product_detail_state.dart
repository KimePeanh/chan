import 'package:lady_skin/src/features/product/models/product.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class ProductDetailState extends Equatable {
  ProductDetailState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchingProductDetail extends ProductDetailState {}

class FetchedProductDetail extends ProductDetailState {
  final Product product;
  FetchedProductDetail({required this.product});
}

class ErrorFetchingProductDetail extends ProductDetailState {
  final String error;
  ErrorFetchingProductDetail({required this.error});
}
