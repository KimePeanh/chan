import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_bloc.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_event.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_state.dart';
import 'package:lady_skin/src/features/product/models/product.dart';

import 'package:lady_skin/src/utils/helper/helper.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class Promotion extends StatefulWidget {
  @override
  _HomeProductListByCategoryState createState() =>
      _HomeProductListByCategoryState();
}

class _HomeProductListByCategoryState extends State<Promotion> {
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
            Navigator.pushNamed(context, productPromotion);
            // Navigator.pushNamed(context, productListByCategory,
            //     arguments: widget.category);
          },
          child: BlocListener<ProductListingBloc, ProductListingState>(
            listener: (context, state) async {
              if (state is FetchedProductList) {
                _refreshController.loadComplete();
                _refreshController.refreshCompleted();
              }
              if (state is EndOfProductList) {
                _refreshController.loadNoData();
              }
            },
            child: Container(
              padding: EdgeInsets.only(top: 10, right: 10),
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Colors.red[400],
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: Helper.randomGradientColor())
                  // gradient: LinearGradient(
                  // colors: [
                  //   Colors.white.withOpacity(0),
                  //   Colors.white.withOpacity(0.1),
                  //   Colors.black.withOpacity(0.5)
                  // ],
                  // begin: FractionalOffset(0, 0),
                  // end: FractionalOffset(0, 1),
                  // stops: [0.0, 0.2, 1.0],
                  // tileMode: TileMode.clamp),
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                    //alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 1, child: Center()),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text("Promotion",
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                    letterSpacing: 0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  AspectRatio(
                    aspectRatio: 10 / 5.5,
                    child: SmartRefresher(
                      scrollDirection: Axis.horizontal,
                      onRefresh: () {
                        BlocProvider.of<ProductListingBloc>(context)
                            .add(InitializeProductList(arg: null));
                      },
                      onLoading: () {
                        if (BlocProvider.of<ProductListingBloc>(context).state
                            is EndOfProductList) {
                        } else {
                          BlocProvider.of<ProductListingBloc>(context)
                              .add(FetchProductList(arg: null));
                        }
                      },
                      enablePullDown: false,
                      enablePullUp: true,
                      controller: _refreshController,
                      child: PromoProductList(
                        isHorizontal: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PromoProductList extends StatelessWidget {
  final bool isHorizontal;
  PromoProductList({this.isHorizontal = true});
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
                  child: Tile(
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
                return Container();
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4 / 5.7,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10),
                itemCount: BlocProvider.of<ProductListingBloc>(context)
                    .productList
                    .length,
                itemBuilder: (context, index) {
                  return Tile(
                    // showIcon: true,
                    product: BlocProvider.of<ProductListingBloc>(context)
                        .productList[index],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final Product product;
  Tile({required this.product});

  @override
  Widget build(BuildContext context) {
    // return Container();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, productDetail, arguments: product);
      },
      child: Container(
        color: Colors.red.withOpacity(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                      color: Colors.white,
                      child: ExtendedImage.network(product.thumbnail,
                          errorWidget: Image.asset(
                              "assets/images/product_placeholder.jpg"),
                          enableMemoryCache: true,
                          clearMemoryCacheWhenDispose: true,
                          clearMemoryCacheIfFailed: false,
                          fit: BoxFit.cover,
                          cache: true,
                          width: 350,
                          cacheHeight: 350)),
                ),
                product.promoPercent != null
                    ? Container(
                        padding: EdgeInsets.all(3),
                        color: Colors.red,
                        child: Text("-" + product.promoPercent.toString(),
                            textScaleFactor: 0.8,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )))
                    : Center(),
              ],
            ),
            SizedBox(height: 10),
            Text(
              product.name,
              maxLines: 1,
              textScaleFactor: 0.8,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "\$" +
                        (product.promoPrice != null || product.promoPrice != ""
                            ? product.promoPrice.toString()
                            : product.price.toString()),
                    maxLines: 1,
                    textScaleFactor: 1.2,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                        color: Colors.white),
                  ),
                ),
                SizedBox(width: 5),
                product.promoPrice != null
                    ? Expanded(
                        child: SizedBox(
                          child: Text(
                            "" +
                                ((product.promoPrice != null)
                                    ? product.price.toString()
                                    : " "),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textScaleFactor: 0.8,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      )
                    : Center()
              ],
            )
          ],
        ),
      ),
    );
  }
}
// class Promotiond extends StatefulWidget {
//   @override
//   _PromotionState createState() => _PromotionState();
// }

// class _PromotionState extends State<Promotion> {
//   final RefreshController _refreshController = RefreshController();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductListingBloc, ProductListingState>(
//       builder: (context, state) {
//         if (state is InitializingProductList) {
//           return Container();
//         }
//         if (BlocProvider.of<ProductListingBloc>(context).productList.length <
//             3) {
//           return Center();
//         }
// //         List<Color> _gradient;
// //         try{
// //  List<Color> _gradient = Helper.randomGradientColor();
// //         }catch(_{
// // _gradient=
// //         }

//         // gradient: LinearGradient(
//         return GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(context, productPromotion);
//           },
//           child: Container(
//             padding: EdgeInsets.all(10),
//             margin: EdgeInsets.only(left: 10, right: 10),
//             decoration: BoxDecoration(
//                 color: Colors.red[400],
//                 borderRadius: BorderRadius.circular(5),
//                 gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: Helper.randomGradientColor())
//                 // gradient: LinearGradient(
//                 // colors: [
//                 //   Colors.white.withOpacity(0),
//                 //   Colors.white.withOpacity(0.1),
//                 //   Colors.black.withOpacity(0.5)
//                 // ],
//                 // begin: FractionalOffset(0, 0),
//                 // end: FractionalOffset(0, 1),
//                 // stops: [0.0, 0.2, 1.0],
//                 // tileMode: TileMode.clamp),
//                 ),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     //alignment: Alignment.center,
//                     margin: EdgeInsets.only(left: 10, right: 10, top: 5),
//                     //alignment: Alignment.centerLeft,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(flex: 1, child: Center()),
//                         Expanded(
//                           flex: 1,
//                           child: Center(
//                             child: Text("Promotion",
//                                 textScaleFactor: 1.2,
//                                 style: TextStyle(
//                                     letterSpacing: 0,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w500)),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Align(
//                               alignment: Alignment.centerRight,
//                               child: Icon(
//                                 Icons.arrow_forward_ios_rounded,
//                                 color: Colors.white,
//                               )),
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Expanded(
//                           child: Container(
//                         child: _tile(
//                             BlocProvider.of<ProductListingBloc>(context)
//                                 .productList[0]),
//                       )),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                           child: Container(
//                         child: _tile(
//                             BlocProvider.of<ProductListingBloc>(context)
//                                 .productList[1]),
//                       )),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                           child: Container(
//                         child: _tile(
//                             BlocProvider.of<ProductListingBloc>(context)
//                                 .productList[2]),
//                       )),
//                     ],
//                   )
//                   // BlocListener<ProductListingBloc, ProductListingState>(
//                   //   listener: (context, state) async {
//                   //     if (state is FetchedProductList) {
//                   //       _refreshController.loadComplete();
//                   //       _refreshController.refreshCompleted();
//                   //     }
//                   //     if (state is EndOfProductList) {
//                   //       _refreshController.loadNoData();
//                   //     }
//                   //   },
//                   //   child: AspectRatio(
//                   //     aspectRatio: 10 / 5.7,
//                   //     child: SmartRefresher(
//                   //       scrollDirection: Axis.horizontal,
//                   //       onRefresh: () {
//                   //         BlocProvider.of<ProductListingBloc>(context)
//                   //             .add(InitializeProductList(arg: null));
//                   //       },
//                   //       onLoading: () {
//                   //         if (BlocProvider.of<ProductListingBloc>(context).state
//                   //             is EndOfProductList) {
//                   //         } else {
//                   //           BlocProvider.of<ProductListingBloc>(context)
//                   //               .add(FetchProductList(arg: null));
//                   //         }
//                   //       },
//                   //       enablePullDown: false,
//                   //       enablePullUp: true,
//                   //       controller: _refreshController,
//                   //       child: ProductList(
//                   //         isHorizontal: false,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                 ]),
//           ),
//         );
//       },
//     );
//   }

//   _tile(Product product) {
//     // return Container();
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(context, productDetail, arguments: product);
//       },
//       child: Container(
//         color: Colors.red.withOpacity(0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               alignment: Alignment.topRight,
//               children: [
//                 AspectRatio(
//                   aspectRatio: 1,
//                   child: Container(
//                     color: Colors.white,
//                     child: FadeInImage.memoryNetwork(
//                       placeholder: kTransparentImage,
//                       imageCacheHeight: 220,
//                       imageCacheWidth: 220,
//                       image: product.thumbnail,
//                       fit: BoxFit.fitWidth,
//                       imageErrorBuilder: (b, c, d) {
//                         return Image.asset(
//                             "assets/images/product_placeholder.jpg");
//                       },
//                     ),
//                   ),
//                 ),
//                 product.promoPercent != null
//                     ? Container(
//                         //alignme...................00000000000nt: Alignment.topRight,
//                         padding: EdgeInsets.all(3),
//                         color: Colors.red,
//                         child: Text("-" + product.promoPercent.toString(),
//                             textScaleFactor: 0.8,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             )))
//                     : Center(),
//               ],
//             ),
//             SizedBox(height: 10),
//             Text(
//               product.name,
//               maxLines: 1,
//               textScaleFactor: 0.8,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(color: Colors.white),
//             ),
//             SizedBox(height: 10),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   alignment: Alignment.bottomLeft,
//                   child: Text(
//                     "\$" +
//                         (product.promoPrice != null || product.promoPrice != ""
//                             ? product.promoPrice.toString()
//                             : product.price.toString()),
//                     maxLines: 1,
//                     textScaleFactor: 1.2,
//                     overflow: TextOverflow.fade,
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 0,
//                         color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(width: 5),
//                 product.promoPrice != null
//                     ? Expanded(
//                         child: SizedBox(
//                           child: Text(
//                             "" +
//                                 ((product.promoPrice != null)
//                                     ? product.price.toString()
//                                     : " "),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             textScaleFactor: 0.8,
//                             style: TextStyle(
//                                 color: Colors.white.withOpacity(0.5),
//                                 decoration: TextDecoration.lineThrough),
//                           ),
//                         ),
//                       )
//                     : Center()
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// List<Color> randomGradientColor() {
//   List<List<Color>> _gradientColorList = [
//     [Color(0xFF8A2387), Color(0xFFE94057), Color(0xFFF27121)],
//     [Color(0xFF), Color(0xFF)],
//     [Color(0xFFbc4e9c), Color(0xFFf80759)],
//     [Color(0xFF642B73), Color(0xFFC6426E)],
//     [Color(0xFFC33764), Color(0xFF1D2671)],
//     [Color(0xFFcb2d3e), Color(0xFFef473a)],
//     [Color(0xFFec008c), Color(0xFFec008c)]
//   ];
//   Random random = new Random();
//   return _gradientColorList[random.nextInt(_gradientColorList.length - 1)];
// }
