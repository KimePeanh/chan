import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_bloc.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_state.dart';
import 'product_tile.dart';
import 'product_tile_skeleton.dart';

class ProductList extends StatelessWidget {
  final bool isHorizontal;
  ProductList({this.isHorizontal = true});
  @override
  Widget build(BuildContext context) {
    if (isHorizontal == false) {
      return BlocBuilder<ProductListingBloc, ProductListingState>(
          builder: (BuildContext context, ProductListingState state) {
        if (BlocProvider.of<ProductListingBloc>(context).productList.length ==
            0) {
          return Container(
            width: 0,
            height: 0,
          );
        }
        //  return Text("hh");
        return Container(
          margin: EdgeInsets.only(left: 10, right: 0),
          child: ListView.builder(
            cacheExtent: 10,
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount:
                BlocProvider.of<ProductListingBloc>(context).productList.length,
            itemBuilder: (context, index) {
              return AspectRatio(
                aspectRatio: 4 / 5.8,
                child: Container(
                  margin: EdgeInsets.only(right: 5),
                  child: ProductTile(
                    isVerticalParent: false,
                    //showIcon: true,
                    product: BlocProvider.of<ProductListingBloc>(context)
                        .productList[index],
                  ),
                ),
              );
            },
          ),
        );
      });
    }
    return Container(
      padding: EdgeInsets.all(10),
      child: BlocBuilder(
        bloc: BlocProvider.of<ProductListingBloc>(context),
        builder: (context, state) {
          if (state is InitializingProductList) {
            return GridView.builder(
              // cacheExtent: 10,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 4 / 5.7,
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10),
              itemCount: 6,
              itemBuilder: (context, index) {
                return productTileSkeleton();
              },
            );
          } else if (state is ErrorFetchingProductList) {
            return Container();
          }
          return Column(
            children: [
              GridView.builder(
                cacheExtent: 0,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // padding: EdgeInsets.only(left: 10, top: 10, right: 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4 / 5.7,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10),
                itemCount: BlocProvider.of<ProductListingBloc>(context)
                    .productList
                    .length,
                itemBuilder: (context, index) {
                  return ProductTile(
                    // showIcon: true,
                    product: BlocProvider.of<ProductListingBloc>(context)
                        .productList[index],
                  );
                },
              ),
              // (state is FetchingProductList)
              // ? GridView.builder(
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     padding:
              //         EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         childAspectRatio: 4 / 5.7,
              //         crossAxisCount: 2,
              //         crossAxisSpacing: 8,
              //         mainAxisSpacing: 10),
              //     itemCount: 6,
              //     itemBuilder: (context, index) {
              //       return productTileSkeleton();
              //     },
              //   )
              // : Container()
            ],
          );
        },
      ),
    );
  }
}
