import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/product/models/product.dart';
import 'package:lady_skin/src/features/product/repositories/product_listing_repository.dart';
import 'product_listing_event.dart';
import 'product_listing_state.dart';

class ProductListingBloc
    extends Bloc<ProductListingEvent, ProductListingState> {
  ProductListingBloc(
      {required this.productListingRepository, this.rowPerPage = 10})
      : super(InitializingProductList());

  final ProductListingRepository productListingRepository;
  late int page;
  List<Product> productList = [];
  final int rowPerPage;
  @override
  Stream<ProductListingState> mapEventToState(
      ProductListingEvent event) async* {
    if (event is InitializeProductList) {
      yield InitializingProductList();
      try {
        page = 1;
        productList = await productListingRepository.getProductList(
            page: page, rowPerPage: rowPerPage, additionalArg: event.arg);
        page++;
        yield InitializedProductList();
      } catch (e) {
        print(e);
        yield ErrorInitializingProductList(error: e.toString());
      }
    }
    if (event is FetchProductList) {
      yield FetchingProductList();
      try {
        List<Product> _tempProductList =
            await productListingRepository.getProductList(
                page: page, rowPerPage: rowPerPage, additionalArg: event.arg);
        productList.addAll(_tempProductList);
        page++;
        if (_tempProductList.length < rowPerPage) {
          yield EndOfProductList();
        } else {
          yield FetchedProductList();
        }
      } catch (e) {
        yield ErrorInitializingProductList(error: e.toString());
      }
    }
  }
}
