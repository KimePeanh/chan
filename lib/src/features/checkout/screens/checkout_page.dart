import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/cart/bloc/index.dart';
import 'package:lady_skin/src/features/cart/screens/widgets/cart_detail_frame.dart';
import 'package:lady_skin/src/features/checkout/bloc/checkout_bloc.dart';
import 'package:lady_skin/src/features/checkout/bloc/checkout_event.dart';
import 'package:lady_skin/src/features/checkout/screens/widgets/payment_method_dialog.dart';
import 'package:lady_skin/src/features/checkout/screens/widgets/select_shipping_address_btn.dart';
import 'package:lady_skin/src/shared/bloc/file_pickup/file_pickup_bloc.dart';
import 'package:lady_skin/src/shared/bloc/indexing/index.dart';
import 'package:lady_skin/src/shared/widgets/custom_dialog.dart';
import 'package:lady_skin/src/shared/widgets/standard_appbar.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';

import 'widgets/cart_item.dart';
import 'widgets/cart_summary.dart';
import 'widgets/payment_type.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
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
          context, AppLocalizations.of(context)!.translate("checkout")),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SelectShippingAddressBtn(
                      buyNowItem: null,
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
                    BlocProvider(
                      create: (BuildContext context) =>
                          paymentMethodIndexingBloc,
                      child: BlocBuilder(
                        bloc: paymentTypeIndexingBloc,
                        builder: (c, state) {
                          if (state == 0) {
                            return Container();
                          } else {
                            paymentMethodIndexingBloc.add(Taped(index: -1));
                            return _paymentMethodWidget(context);
                          }
                        },
                      ),
                    ),
                    BlocBuilder(
                      bloc: paymentTypeIndexingBloc,
                      builder: (context, state) {
                        if (state != 0) {
                          return Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    standardBorderRadius)),
                            child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: AspectRatio(
                                            aspectRatio: 1,
                                            child: BlocBuilder(
                                              bloc: _filePickupBloc,
                                              builder:
                                                  (context, dynamic state) {
                                                return FittedBox(
                                                    fit: BoxFit.fitHeight,
                                                    child: (state == null)
                                                        ? Icon(
                                                            Icons
                                                                .add_a_photo_outlined,
                                                            color: Colors
                                                                .grey[300],
                                                          )
                                                        : Image.file(state));
                                              },
                                            )),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        }
                        return Container();
                      },
                    ),
                    BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                      // Helper.handleState(state: state, context: context);
                      if (state is ErrorFetchingCart) {
                        Helper.handleState(state: state, context: context);
                        return TextButton(
                            child: Text("Retry"),
                            onPressed: () {
                              BlocProvider.of<CartBloc>(context)
                                  .add(FetchCart());
                            });
                      } else if (state is FetchingCart) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(children: [
                        CartItem(),
                        SizedBox(
                          height: 5,
                        ),
                        CartSummary(
                          cart: BlocProvider.of<CartBloc>(context).cart,
                        ),
                      ]);
                    })
                  ],
                ),
              ),
            ),
            // BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            //   if (state is FetchedCart) {
            //     return _cartDetailFrame();
            //   }
            // })
            _cartDetailFrame(),
          ],
        ),
      ),
    );
  }

  _cartDetailFrame() {
    return Builder(
      builder: (context) {
        return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          // Helper.handleState(state: state, context: context);
          if (state is FetchedCart) {
            return CartDetailFrame(
                total: BlocProvider.of<CartBloc>(context).cart.grandTotal,
                btnText: AppLocalizations.of(context)!.translate("submit"),
                onBtnPressed: () {
                  if (selectShippingAddressBloc.address == null) {
                    customDialog(context, "",
                        Text("Please select shipping address"), () {});
                  } else {
                    if (paymentTypeIndexingBloc.state == 0) {
                      BlocProvider.of<CheckoutBloc>(context).add(
                          CheckoutStarted(
                              addressId:
                                  selectShippingAddressBloc.address!.id));
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
                            CheckoutWithTransferStarted(
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
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 15),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .translate("chooseTransferMethod"),
                        style: Theme.of(context).primaryTextTheme.subtitle1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Divider(),
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
