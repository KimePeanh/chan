import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/product/models/product.dart';
import 'package:lady_skin/src/features/product/repositories/product_detail_repository.dart';

import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailRepository _productDetailRepository = ProductDetailRepository();
  @override
  ProductDetailBloc() : super(FetchingProductDetail());

  @override
  Stream<ProductDetailState> mapEventToState(ProductDetailEvent event) async* {
    if (event is FetchProductDetail) {
      yield FetchingProductDetail();
      try {
        final Product product = await _productDetailRepository.getProduct(
            productId: event.productId);

        yield FetchedProductDetail(product: product);
      } catch (e) {
        yield ErrorFetchingProductDetail(error: e.toString());
      }
    }
  }
}
