import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_bloc.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_event.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_state.dart';
import 'package:lady_skin/src/features/product/repositories/product_listing_repository.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/product_list.dart';

class ProductListByPromotionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (c, state) {
        if (state is Authenticating) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              brightness: Brightness.dark,
              centerTitle: true,
              title: Text(
                "Promotion",
                style: TextStyle(color: Colors.white),
              ),
              // backgroundColor: Colors.red
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: Helper.randomGradientColor())),
              ),
            ),
            body: BlocProvider(
              create: (BuildContext context) => ProductListingBloc(
                  productListingRepository: ProductListByPromotionRepo(
                      isAuthenticated:
                          (BlocProvider.of<AuthenticationBloc>(context).state
                                  is Authenticated
                              ? true
                              : false)))
                ..add(InitializeProductList()),
              child: Body(),
            ),
          );
        }
      },
    );
  }
}

class Body extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductListingBloc, ProductListingState>(
      listener: (context, state) {
        if (state is InitializedProductList || state is FetchedProductList) {
          _refreshController.loadComplete();
          _refreshController.refreshCompleted();
        }
        if (state is EndOfProductList) {
          _refreshController.loadNoData();
        }
      },
      child: SmartRefresher(
        physics: AlwaysScrollableScrollPhysics(),
        onRefresh: () {
          BlocProvider.of<ProductListingBloc>(context)
              .add(InitializeProductList());
        },
        onLoading: () {
          if (BlocProvider.of<ProductListingBloc>(context).state
              is EndOfProductList) {
          } else {
            BlocProvider.of<ProductListingBloc>(context)
                .add(FetchProductList(arg: null));
          }
        },
        footer: ClassicFooter(),
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProductList(),
            ],
          ),
        ),
      ),
    );
  }
}
