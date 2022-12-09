import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:lady_skin/src/features/product/bloc/index.dart';
import 'package:lady_skin/src/features/product/screens/widgets/product_list.dart';

class ProductListByStoreCategory extends StatefulWidget {
  final String storeId;
  final String categoryId;
  ProductListByStoreCategory({required this.storeId, required this.categoryId});

  @override
  _ProductListByStoreCategoryState createState() =>
      _ProductListByStoreCategoryState();
}

class _ProductListByStoreCategoryState extends State<ProductListByStoreCategory>
    with AutomaticKeepAliveClientMixin<ProductListByStoreCategory> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => ProductBloc()
        ..add(FetchByStoreCategoryStarted(
            categoryId: widget.categoryId, storeId: widget.storeId)),
      child: Body(
        storeId: widget.storeId,
        categoryId: widget.categoryId,
      ),
    );
  }
}

class Body extends StatelessWidget {
  final String storeId;
  final String categoryId;
  Body({required this.storeId, required this.categoryId});
  final RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is FetchedProduct) {
          _refreshController.loadComplete();
          _refreshController.refreshCompleted();
        }
      },
      child: SmartRefresher(
        onRefresh: () {
          BlocProvider.of<ProductBloc>(context).add(FetchByStoreCategoryStarted(
              isRefresh: true,
              categoryId: this.categoryId,
              storeId: this.storeId));
        },
        onLoading: () {
          BlocProvider.of<ProductBloc>(context).add(FetchByStoreCategoryStarted(
              isRefresh: false,
              categoryId: this.categoryId,
              storeId: this.storeId));
        },
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        child: SingleChildScrollView(
          child: Column(
            children: [ProductList()],
          ),
        ),
      ),
    );
  }
}
