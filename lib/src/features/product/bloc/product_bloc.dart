import 'package:bloc/bloc.dart';

import 'package:lady_skin/src/features/product/models/product.dart';
import 'package:lady_skin/src/features/product/repositories/product_repository.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(Initializing());

  final ProductRepository productRepository = ProductRepository();
  int productPage = 1;
  List<Product> productList = [];

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchStarted ||
        event is FetchByCategoryStarted ||
        event is FetchByStoreCategoryStarted ||
        event is FetchBySubCategoryStarted) {
      yield (productPage == 1) ? Initializing() : FetchingProduct();
      if (event.isRefresh) {
        productPage = 1;
      }
      try {
        final List<Product> productlistTemp =
            await ((event is FetchByCategoryStarted)
                ? productRepository.getProductByCategory(
                    page: productPage, categoryId: event.categoryId)
                : (event is FetchBySubCategoryStarted)
                    ? productRepository.getProductBySubCategory(
                        page: productPage, subCategoryId: event.subCategoryId)
                    : (event is FetchByStoreCategoryStarted)
                        ? productRepository.getProductByStoreCategory(
                            page: productPage,
                            storeId: event.storeId,
                            categoryId: event.categoryId)
                        : productRepository.getProductsByDefault(
                            page: productPage,
                          ));
        if (event.isRefresh) {
          productList.clear();
        }
        productList.addAll(productlistTemp);
        productPage++;
        yield FetchedProduct();
      } catch (_) {
        yield ErrorFetchingProduct(error: _.toString());
      }
    }
  }
}
