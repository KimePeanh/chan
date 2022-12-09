import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
  ProductDetailEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchProductDetail extends ProductDetailEvent {
  final String productId;
  FetchProductDetail({required this.productId});
}
