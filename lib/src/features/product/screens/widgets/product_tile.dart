import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/favourite/bloc/index.dart';
import 'package:lady_skin/src/features/product/models/product.dart';

class ProductTile extends StatefulWidget {
  ProductTile({required this.product, this.isVerticalParent = true});
  final bool isVerticalParent;
  final Product product;
  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, productDetail, arguments: widget.product);
      },
      child: Card(
        key: _globalKey,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 2,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 4,
                    child: Container(
                        width: double.infinity,
                        child: ExtendedImage.network(widget.product.thumbnail,
                            // width: ScreenUtil.instance.setWidth(400),
                            // height: ScreenUtil.instance.setWidth(400),
                            // errorBuilder: Image.asset(
                            //     "assets/images/product_placeholder.jpg"),
                            errorWidget: Image.asset(
                                "assets/images/product_placeholder.jpg"),
                            enableMemoryCache: true,
                            clearMemoryCacheWhenDispose: true,
                            clearMemoryCacheIfFailed: false,
                            fit: BoxFit.cover,
                            cache: true,
                            width: 350,
                            cacheHeight: 350

                            // border: Border.all(color: Colors.red, width: 1.0),
                            // shape: boxShape,
                            // borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            //cancelToken: cancellationToken,
                            )
                        // FadeInImage.memoryNetwork(
                        //   placeholder: kTransparentImage,
                        //   imageCacheHeight:
                        //       (widget.isVerticalParent) ? 350 : 250,
                        //   imageCacheWidth:
                        //       (widget.isVerticalParent) ? 350 : 250,
                        //   image: widget.product.thumbnail,
                        //   fit: BoxFit.fitWidth,
                        //   imageErrorBuilder: (b, c, d) {
                        //     return Image.asset(
                        //         "assets/images/product_placeholder.jpg");
                        //   },
                        // )
                        ),
                  ),
                  widget.product.promoPercent != null
                      ? Container(
                          //alignme...................00000000000nt: Alignment.topRight,
                          padding: EdgeInsets.all(3),
                          color: Colors.red,
                          child: Text("-" + widget.product.promoPercent!,
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )))
                      : Center(),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              flex: 25,
              child: Container(
                padding: EdgeInsets.all(5),
                //color: Colors.grey,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${widget.product.name}",
                    maxLines: 2,
                    style: TextStyle(
                        letterSpacing: 0,
                        color: Theme.of(context).textTheme.headline1!.color,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    textScaleFactor: 0.9,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                //color: Colors.pink,
                child: Row(
                  children: [
                    Expanded(
                      flex: 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "" +
                                  (widget.product.promoPrice ??
                                      widget.product.price),
                              maxLines: 1,
                              textScaleFactor: 1.1,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                  color: Colors.red[300]),
                            ),
                          ),
                          SizedBox(width: 5),
                          widget.product.promoPrice != null
                              ? Expanded(
                                  child: SizedBox(
                                    child: Text(
                                      "" +
                                          ((widget.product.promoPrice != null)
                                              ? widget.product.price
                                              : " "),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textScaleFactor: 0.8,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  ),
                                )
                              : Center()
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 20,
                        child: Container(
                            alignment: Alignment.topRight,
                            child: FittedBox(
                                child: favouriteIcon(context, widget.product))))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget favouriteIcon(
  context,
  Product product,
) {
  return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
    if (authState is Authenticated) {
      return BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          // Helper.handleState(state: state, context: context);
          if (BlocProvider.of<FavouriteBloc>(context).favouriteList.length ==
                  0 ||
              BlocProvider.of<FavouriteBloc>(context).state is FavouriteEmpty) {
            return GestureDetector(
              onTap: () {
                BlocProvider.of<FavouriteBloc>(context)
                    .add(AddToFavourite(product: product));
              },
              child: Icon(
                Icons.favorite_border_outlined,
                color: Colors.red,
              ),
            );
          } else {
            if (state is AddingToFavourite) {
              if (product.id == state.productId) {
                return AspectRatio(
                    aspectRatio: 4 / 4,
                    child: Center(child: CircularProgressIndicator()));
              } else {
                bool isFavourite = false;
                BlocProvider.of<FavouriteBloc>(context)
                    .favouriteList
                    .forEach((element) {
                  if (element.product.id == product.id) {
                    isFavourite = true;
                  }
                });
                if (isFavourite) {
                  return Icon(Icons.favorite, color: Colors.red);
                } else {
                  return Icon(Icons.favorite_border_outlined,
                      color: Colors.red);
                }
              }
            } else {
              bool isFavourite = false;
              BlocProvider.of<FavouriteBloc>(context)
                  .favouriteList
                  .forEach((element) {
                if (element.product.id == product.id) {
                  isFavourite = true;
                }
              });
              if (isFavourite) {
                return GestureDetector(
                    onTap: () {
                      //  BlocProvider.of<FavouriteBloc>(context)
                      //       .add(RemoveFromFavourite(favourite: product));
                    },
                    child: Icon(Icons.favorite, color: Colors.red));
              } else {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<FavouriteBloc>(context)
                        .add(AddToFavourite(product: product));
                  },
                  child:
                      Icon(Icons.favorite_border_outlined, color: Colors.red),
                );
              }
            }
          }
        },
      );
    } else {
      return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, loginRegister, arguments: true);
          },
          child: Icon(Icons.favorite_outline, color: Colors.red));
    }
  });
}
