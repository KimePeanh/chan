import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/cart/bloc/index.dart';
import 'package:lady_skin/src/features/cart/models/cart_item.dart';

class CartProductTile extends StatelessWidget {
  CartProductTile(
      {required this.cartData,
      this.showDeleteBtn = true,
      this.editable = true});
  final CartItem cartData;
  final bool showDeleteBtn;
  final bool editable;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, productDetail,
            arguments: cartData.product);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ProductDetailPage(
        //             product: BlocProvider.of<CartBloc>(context)
        //                 .cart
        //                 .data[tileIndex]
        //                 .product)));
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.only(top: 15),
        child: AspectRatio(
          aspectRatio: 3 / 0.8,
          child: Row(
            children: [
              AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: cartData.product.thumbnail,
                          placeholder: (context, url) => Image.asset(
                              "assets/images/product_placeholder.jpg",
                              fit: BoxFit.cover),
                          errorWidget: (context, url, error) => Opacity(
                                opacity: 0.2,
                                child: Image.asset(
                                    "assets/images/product_placeholder.jpg"),
                              )))),
              SizedBox(width: 10),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 85,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(5)),
                          child: Container(
                            // color: Colors.green,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    //color: Colors.green,
                                    child: Text(
                                      (cartData.variantName == null ||
                                              cartData.variantName!.length == 0)
                                          ? cartData.product.name
                                          : cartData.variantName!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .color,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: (this.showDeleteBtn)
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons.clear,
                                                    color: Colors.red[300],
                                                  ),
                                                  onPressed: () {
                                                    // String variantOption;
                                                    // if (cartData
                                                    //         .product
                                                    //         .variantOptionTypeList
                                                    //         .length !=
                                                    //     0) {
                                                    //   variantOption =
                                                    //       cartData.variantId;
                                                    // } else {
                                                    //   variantOption = null;
                                                    // }

                                                    BlocProvider.of<CartBloc>(
                                                            context)
                                                        .add(RemoveFromCart(
                                                      cartId: cartData.id,
                                                    ));
                                                  },
                                                )
                                              : Center()),
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 85,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5)),
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 45,
                                  child: Container(
                                      child: Text(
                                    "" + cartData.grandTotal,
                                    textScaleFactor: 1,
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .color,
                                    ),
                                  )),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 45,
                                  child: (this.editable)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: double.infinity,
                                                child: FittedBox(
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.fitHeight,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        if (cartData.quantity !=
                                                            1) {
                                                          BlocProvider.of<
                                                                      CartBloc>(
                                                                  context)
                                                              .add(SetQuantity(
                                                            cartId: cartData.id,
                                                            quantity: cartData
                                                                    .quantity -
                                                                1,
                                                          ));
                                                        }
                                                      },
                                                      icon: Icon(
                                                        Icons.remove,
                                                        color: Colors.grey[600],
                                                      )),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    cartData.quantity
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: double.infinity,
                                                child: FittedBox(
                                                  fit: BoxFit.fitHeight,
                                                  alignment: Alignment.center,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        // String variantOption;
                                                        // if (cartData
                                                        //         .product
                                                        //         .variantOptionTypeList
                                                        //         .length !=
                                                        //     0) {
                                                        //   variantOption =
                                                        //       cartData.variantId;
                                                        // } else {
                                                        //   variantOption = null;
                                                        // }
                                                        BlocProvider.of<
                                                                    CartBloc>(
                                                                context)
                                                            .add(SetQuantity(
                                                          cartId: cartData.id,
                                                          quantity: cartData
                                                                  .quantity +
                                                              1,
                                                        ));
                                                      },
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: Colors.grey[600],
                                                      )),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : Text(
                                          "${AppLocalizations.of(context)!.translate('quantity')}: ${cartData.quantity}"),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
