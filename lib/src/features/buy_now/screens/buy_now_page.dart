import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/buy_now/bloc/index.dart';
import 'package:lady_skin/src/features/buy_now/models/buy_now_item.dart';

import 'package:lady_skin/src/features/cart/screens/widgets/cart_detail_frame.dart';
import 'package:lady_skin/src/features/cart/screens/widgets/cart_product_tile.dart';
import 'package:lady_skin/src/features/checkout/bloc/checkout_bloc.dart';
import 'package:lady_skin/src/features/checkout/bloc/checkout_event.dart';

import 'package:lady_skin/src/features/checkout/screens/widgets/cart_summary.dart';
import 'package:lady_skin/src/features/checkout/screens/widgets/payment_method_dialog.dart';
import 'package:lady_skin/src/features/checkout/screens/widgets/payment_type.dart';
import 'package:lady_skin/src/features/checkout/screens/widgets/select_shipping_address_btn.dart';

import 'package:lady_skin/src/shared/bloc/file_pickup/file_pickup_bloc.dart';
import 'package:lady_skin/src/shared/bloc/indexing/index.dart';
import 'package:lady_skin/src/shared/widgets/custom_dialog.dart';
import 'package:lady_skin/src/shared/widgets/standard_appbar.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';

class BuyNowPage extends StatelessWidget {
  final BuyNowItem buyNowItem;
  BuyNowPage({required this.buyNowItem});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => BuyNowBloc()
          ..add(FetchBuyNow(addressId: null, buyNowItem: buyNowItem)),
        child: BuyNowPageBody(
          buyNowItem: buyNowItem,
        ),
      ),
    );
  }
}

class BuyNowPageBody extends StatefulWidget {
  final BuyNowItem buyNowItem;
  BuyNowPageBody({required this.buyNowItem});
  @override
  _BuyNowPageBodyState createState() => _BuyNowPageBodyState();
}

class _BuyNowPageBodyState extends State<BuyNowPageBody> {
  IndexingBloc paymentTypeIndexingBloc = IndexingBloc();
  IndexingBloc paymentMethodIndexingBloc = IndexingBloc();
  FilePickupBloc _filePickupBloc = FilePickupBloc();

  @override
  void dispose() {
    paymentTypeIndexingBloc.close();
    paymentMethodIndexingBloc.close();
    _filePickupBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(
          context, AppLocalizations.of(context)!.translate("buyNow")),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SelectShippingAddressBtn(
                      buyNowItem: widget.buyNowItem,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    BlocProvider(
                        create: (BuildContext context) =>
                            paymentTypeIndexingBloc,
                        child: PaymentType()),
                    SizedBox(
                      height: 15,
                    ),
                    BlocBuilder<BuyNowBloc, BuyNowState>(
                      builder: (context, state) {
                        if (state is ErrorFetchingBuyNow) {
                          Helper.handleState(state: state, context: context);
                          return Center(
                            child: TextButton(
                              onPressed: () {
                                BlocProvider.of<BuyNowBloc>(context).add(
                                    FetchBuyNow(
                                        buyNowItem: widget.buyNowItem,
                                        addressId: null));
                              },
                              child: Text("Retry"),
                            ),
                          );
                        } else if (state is FetchedBuyNow) {
                          return Column(
                            children: [
                              BlocProvider(
                                create: (BuildContext context) =>
                                    paymentMethodIndexingBloc,
                                child: BlocBuilder(
                                  bloc: paymentTypeIndexingBloc,
                                  builder: (c, state) {
                                    if (state == 0) {
                                      return Container();
                                    } else {
                                      paymentMethodIndexingBloc
                                          .add(Taped(index: -1));
                                      return _paymentMethodWidget(context);
                                    }
                                  },
                                ),
                              ),
                              BlocBuilder(
                                bloc: paymentTypeIndexingBloc,
                                builder: (context, state) {
                                  if (state != 0) {
                                    return Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            // color: Theme.of(context).buttonColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    standardBorderRadius))),
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(AppLocalizations.of(context)!
                                                .translate("uploadTransImage")),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Divider(),
                                            GestureDetector(
                                              onTap: () {
                                                _showPicker(context);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: AspectRatio(
                                                    aspectRatio: 1,
                                                    child: BlocBuilder(
                                                      bloc: _filePickupBloc,
                                                      builder: (context,
                                                          dynamic state) {
                                                        return FittedBox(
                                                            fit: BoxFit
                                                                .fitHeight,
                                                            child: (state ==
                                                                    null)
                                                                ? Icon(
                                                                    Icons
                                                                        .add_a_photo_outlined,
                                                                    color: Colors
                                                                            .grey[
                                                                        300],
                                                                  )
                                                                : Image.file(
                                                                    state));
                                                      },
                                                    )),
                                              ),
                                            )
                                          ],
                                        ));
                                  }
                                  return Container();
                                },
                              ),
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      // color: Theme.of(context).buttonColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              standardBorderRadius))),
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate("item"),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle1,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(),
                                      CartProductTile(
                                        showDeleteBtn: false,
                                        editable: false,
                                        cartData: state.cart.data[0],
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              CartSummary(cart: state.cart)
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            // BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            //   if (state is FetchedCart) {
            //     return _cartDetailFrame();
            //   }
            // })
            _detailFrame(),
          ],
        ),
      ),
    );
  }

  _detailFrame() {
    return Builder(
      builder: (context) {
        return BlocBuilder<BuyNowBloc, BuyNowState>(builder: (context, state) {
          if (state is FetchedBuyNow) {
            return CartDetailFrame(
                total: state.cart.grandTotal,
                btnText: AppLocalizations.of(context)!.translate("submit"),
                onBtnPressed: () {
                  if (selectShippingAddressBloc.address == null) {
                    customDialog(context, "",
                        Text("Please select shipping address"), () {});
                  } else {
                    if (paymentTypeIndexingBloc.state == 0) {
                      BlocProvider.of<CheckoutBloc>(context).add(BuyNowStarted(
                          buyNowItem: widget.buyNowItem,
                          addressId: selectShippingAddressBloc.address!.id));
                      Navigator.pushNamed(context, checkoutStatus);
                    } else {
                      if (paymentMethodIndexingBloc.state == (-1)) {
                        customDialog(
                            context,
                            "",
                            Text(AppLocalizations.of(context)!
                                .translate("pleaseChooseTransfer")),
                            () {});
                      } else if (_filePickupBloc.state == null) {
                        customDialog(
                            context,
                            "",
                            Text(AppLocalizations.of(context)!
                                .translate("pleaseChooseTransImage")),
                            () {});
                      } else {
                        BlocProvider.of<CheckoutBloc>(context).add(
                            BuyNowWithTransferStarted(
                                buyNowItem: widget.buyNowItem,
                                transferImage: _filePickupBloc.state,
                                paymentMethod: paymentMethodList[
                                    paymentMethodIndexingBloc.state]["name"],
                                addressId:
                                    selectShippingAddressBloc.address!.id));
                        Navigator.pushNamed(context, checkoutStatus);
                      }
                    }
                  }

                  // Navigator.pushNamed(context, checkout);
                });
          } else
            return Center();
        });
      },
    );
  }

  _paymentMethodWidget(BuildContext contextt) {
    return Builder(
      builder: (c) {
        return BlocBuilder(
          bloc: BlocProvider.of<IndexingBloc>(c),
          builder: (context, int state) {
            return GestureDetector(
              onTap: () {
                paymentMethodDialog(c);
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // color: Theme.of(context).buttonColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(standardBorderRadius))),
                  margin: EdgeInsets.only(bottom: 15),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!
                          .translate("chooseTransferMethod")),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      (paymentMethodIndexingBloc.state == (-1))
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate("choose here"),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  flex: 20,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Image(
                                      // width: 15,
                                      // height: 15,
                                      image: AssetImage(
                                          paymentMethodList[state]["image"]),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    flex: 80,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(paymentMethodList[state]["name"],
                                            textScaleFactor: 1.1),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            paymentMethodList[state]
                                                ["description"],
                                            textScaleFactor: 1.1),
                                      ],
                                    )),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                    ],
                  )),
            );
          },
        );
      },
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        Helper.imgFromGallery((image) {
                          _filePickupBloc.add(image);
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Helper.imgFromCamera((image) {
                        _filePickupBloc.add(image);
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
