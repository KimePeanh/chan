import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/category/models/category.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_bloc.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_event.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_state.dart';
import 'package:lady_skin/src/features/product/screens/widgets/product_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeProductListByCategory extends StatefulWidget {
  final Category category;
  HomeProductListByCategory({required this.category});
  @override
  _HomeProductListByCategoryState createState() =>
      _HomeProductListByCategoryState();
}

class _HomeProductListByCategoryState extends State<HomeProductListByCategory> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListingBloc, ProductListingState>(
      builder: (context, state) {
        if (state is InitializingProductList) {
          return Container();
        }
        if (BlocProvider.of<ProductListingBloc>(context).productList.length <
            3) {
          return Center();
        }
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, productListByCategory,
                arguments: widget.category);
          },
          child: Column(children: [
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 10),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, right: 10),
              //alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(widget.category.name,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            color: Theme.of(context).textTheme.headline1!.color,
                            fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 5),
                    child: Text(AppLocalizations.of(context)!.translate("all"),
                        textScaleFactor: 1.1),
                  ),
                  //         Container(padding:EdgeInsets.symmetric(horizontal:10),
                  // IconButton(
                  //     icon: Icon(Icons.arrow_forward_outlined),
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, productListByCategory,
                  //           arguments: widget.category);
                  //     })
                ],
              ),
            ),
            BlocListener<ProductListingBloc, ProductListingState>(
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
                aspectRatio: 10 / 5.9,
                child: SmartRefresher(
                  scrollDirection: Axis.horizontal,
                  onRefresh: () {
                    BlocProvider.of<ProductListingBloc>(context)
                        .add(InitializeProductList(arg: widget.category.id));
                  },
                  onLoading: () {
                    if (BlocProvider.of<ProductListingBloc>(context).state
                        is EndOfProductList) {
                    } else {
                      BlocProvider.of<ProductListingBloc>(context)
                          .add(FetchProductList(arg: widget.category.id));
                    }
                  },
                  enablePullDown: false,
                  enablePullUp: true,
                  controller: _refreshController,
                  child: ProductList(
                    isHorizontal: false,
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
