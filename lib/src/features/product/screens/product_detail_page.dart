import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/cart/bloc/index.dart';
import 'package:lady_skin/src/features/product/bloc/product_detail/product_detail_bloc.dart';
import 'package:lady_skin/src/features/product/bloc/product_detail/product_detail_event.dart';
import 'package:lady_skin/src/features/product/bloc/product_detail/product_detail_state.dart';
import 'package:lady_skin/src/features/product/models/product.dart';
import 'package:lady_skin/src/shared/widgets/error_snackbar.dart';
import 'package:lady_skin/src/shared/widgets/image_slider.dart';

import 'widgets/add_to_cart_modal.dart';
import 'widgets/btn_add_to_cart.dart';
import 'widgets/btn_buy_now.dart';
import 'widgets/buy_now_modal.dart';
import 'widgets/product_detail_body.dart';
import 'widgets/product_tile.dart';

class ProductDetailPageWrapper extends StatefulWidget {
  final dynamic productOrId;
  ProductDetailPageWrapper({required this.productOrId});

  @override
  _ProductDetailPageWrapperState createState() =>
      _ProductDetailPageWrapperState();
}

class _ProductDetailPageWrapperState extends State<ProductDetailPageWrapper> {
  final ProductDetailBloc productDetailBloc = ProductDetailBloc();
  @override
  void dispose() {
    productDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.productOrId is Product) {
      return ProductDetailPage(
        product: widget.productOrId,
      );
    } else {
      productDetailBloc.add(FetchProductDetail(productId: widget.productOrId));
      return BlocConsumer(
          bloc: productDetailBloc,
          listener: (c, state) {
            if (state is ErrorFetchingProductDetail) {
              errorSnackBar(text: state.error.toString(), context: context);
            }
          },
          builder: (c, state) {
            if (state is ErrorFetchingProductDetail) {
              return Scaffold(
                body: Center(
                  child: TextButton(
                    onPressed: () {
                      productDetailBloc.add(
                          FetchProductDetail(productId: widget.productOrId));
                    },
                    child: Text("Retry"),
                  ),
                ),
              );
            } else if (state is FetchedProductDetail) {
              return ProductDetailPage(
                product: state.product,
              );
            } else {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          });
    }
  }
}

class ProductDetailPage extends StatefulWidget {
  final Product product;
  ProductDetailPage({required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List taps = [
    {"name": "description"},
    {"name": "specification"}
  ];
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.product.variantOptionTypeList.forEach((data) {
      data.variantOptionTypeDataList.forEach((element) {});
    });
    double width = MediaQuery.of(context).size.width;
    //return Test();back
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverSafeArea(
                        top: false,
                        sliver: SliverAppBar(
                          brightness: Theme.of(context).brightness,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          leading: AspectRatio(
                            aspectRatio: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: RawMaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                elevation: 0.0,
                                fillColor: Colors.white.withOpacity(0.3),
                                child: Icon(Icons.arrow_back_rounded,
                                    color: Colors.black),
                                shape: CircleBorder(),
                              ),
                            ),
                          ),
                          expandedHeight: width,
                          floating: false,
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(
                            background: (widget.product.images == null ||
                                    widget.product.images!.length == 0)
                                ? Opacity(
                                    opacity: 0.2,
                                    child: Image.asset(
                                        "assets/images/product_placeholder.jpg"),
                                  )
                                : ImageSlider(
                                    fit: BoxFit.fitWidth,
                                    aspectRatio: 4 / 4,
                                    duration: 10000,
                                    images: widget.product.images!,
                                    autoPlay: false,
                                    showDot: false,
                                    willCache: false,
                                  ),
                          ),
                          actions: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child:
                                      favouriteIcon(context, widget.product)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, cart,
                                    arguments: true);
                              },
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Badge(
                                  badgeContent:
                                      BlocBuilder<CartBloc, CartState>(
                                    builder: (context, state) {
                                      // Helper.handleState(
                                      //     state: state, context: context);
                                      if (state is FetchedCart) {
                                        return Text(
                                          BlocProvider.of<CartBloc>(context)
                                              .cart
                                              .data
                                              .length
                                              .toString(),
                                          textScaleFactor: 0.6,
                                          style: TextStyle(color: Colors.white),
                                        );
                                      }
                                      return Text("");
                                    },
                                  ),
                                  position:
                                      BadgePosition.topEnd(top: 3, end: 8),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                      child: Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0)),
                    ),
                    child: ProductDetailBody(product: widget.product))),
          ),
          Container(
            color: Colors.transparent,
            // margin: EdgeInsets.only(left: 15, bottom: 25, right: 15),
            child: Row(
              children: [
                Expanded(child: btnBuyNow(onPressed: () {
                  buyNowModal(context, widget.product);
                })),
                // BtnAddToCart(
                //   product: widget.product,
                // ),
                // SizedBox(width: 15),
                Expanded(child: btnAddToCart(onPressed: () {
                  addToCartModal(context, widget.product);
                }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
