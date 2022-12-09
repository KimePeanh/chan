import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_bloc.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_event.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_state.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:lady_skin/src/features/product/screens/widgets/product_list.dart';
import 'package:lady_skin/src/features/sub_category/models/sub_category.dart';

class ProductListBySubCategory extends StatefulWidget {
  final SubCategory subCategory;
  ProductListBySubCategory({required this.subCategory});
  @override
  _ProductListBySubCategoryState createState() =>
      _ProductListBySubCategoryState();
}

class _ProductListBySubCategoryState extends State<ProductListBySubCategory> {
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    BlocProvider.of<ProductListingBloc>(context)
        .add(InitializeProductList(arg: widget.subCategory.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListingBloc, ProductListingState>(
      builder: (context, state) {
        if (state is InitializingProductList) {
          return Center(child: CircularProgressIndicator());
        }
        // if (BlocProvider.of<ProductListingBloc>(context).productList.length <
        //     3) {
        //   return Center();
        // }
        return BlocListener<ProductListingBloc, ProductListingState>(
          listener: (context, state) async {
            if (state is FetchedProductList) {
              _refreshController.loadComplete();
              _refreshController.refreshCompleted();
            }
            if (state is EndOfProductList) {
              _refreshController.loadNoData();
            }
          },
          child: AspectRatio(
            aspectRatio: 10 / 5.7,
            child: SmartRefresher(
              scrollDirection: Axis.vertical,
              onRefresh: () {
                BlocProvider.of<ProductListingBloc>(context)
                    .add(InitializeProductList(arg: widget.subCategory.id));
              },
              onLoading: () {
                if (BlocProvider.of<ProductListingBloc>(context).state
                    is EndOfProductList) {
                } else {
                  BlocProvider.of<ProductListingBloc>(context)
                      .add(FetchProductList(arg: widget.subCategory.id));
                }
              },
              enablePullDown: true,
              enablePullUp: true,
              controller: _refreshController,
              child: SingleChildScrollView(
                child: ProductList(
                  isHorizontal: true,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
