import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/account/bloc/index.dart';
import 'package:lady_skin/src/features/buy_now/bloc/buy_now_bloc.dart';
import 'package:lady_skin/src/features/buy_now/bloc/buy_now_event.dart';
import 'package:lady_skin/src/features/buy_now/models/buy_now_item.dart';
import 'package:lady_skin/src/features/cart/bloc/index.dart';
import 'package:lady_skin/src/features/shipping_address/bloc/select_shipping_address_bloc.dart';

import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';

SelectShippingAddressBloc selectShippingAddressBloc =
    SelectShippingAddressBloc();

class SelectShippingAddressBtn extends StatefulWidget {
  final BuyNowItem? buyNowItem;
  // static Address selectedShippingAddress;
  SelectShippingAddressBtn({required this.buyNowItem});
  @override
  _SelectShippingAddressBtnState createState() =>
      _SelectShippingAddressBtnState();
}

class _SelectShippingAddressBtnState extends State<SelectShippingAddressBtn> {
  @override
  void dispose() {
    // selectShippingAddressBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        // Helper.handleState(state: state, context: context);
        if (state is FetchedAccount) {
          if (state.user.address == null) {
            return _button(
                child: BlocBuilder(
                  bloc: selectShippingAddressBloc,
                  builder: (context, state) {
                    if (state is Selected) {
                      widget.buyNowItem == null
                          ? BlocProvider.of<CartBloc>(context).add(FetchCart(
                              addressId: selectShippingAddressBloc.address!.id))
                          : BlocProvider.of<BuyNowBloc>(context)
                              .add(FetchBuyNow(buyNowItem: widget.buyNowItem!));
                    }
                    return Text(
                      state is Selecting
                          ? AppLocalizations.of(context)!
                              .translate('chooseShippingAddress')
                          : selectShippingAddressBloc.address!.description!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red[300]),
                      textScaleFactor: 1,
                    );
                  },
                ),
                onPressed: () {
                  Navigator.pushNamed(context, shippingAddress,
                      arguments: false);
                });
          }
          selectShippingAddressBloc.address = state.user.address!;
          return _button(
              child: BlocBuilder(
                bloc: selectShippingAddressBloc,
                builder: (context, state) {
                  if (state is Selected) {
                    widget.buyNowItem == null
                        ? BlocProvider.of<CartBloc>(context).add(FetchCart(
                            addressId: selectShippingAddressBloc.address!.id))
                        : BlocProvider.of<BuyNowBloc>(context)
                            .add(FetchBuyNow(buyNowItem: widget.buyNowItem!));
                  }
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          //state is Selecting
                          // ? AppLocalizations.of(context)!
                          //     .translate("shipToDefault")
                          // :
                          "Ship to " +
                              selectShippingAddressBloc.address!.description!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                          textScaleFactor: 1,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  );
                },
              ),
              onPressed: () {
                Navigator.pushNamed(context, shippingAddress, arguments: false);
              });
        } else if (state is ErrorFetchingAccount) {
          Helper.handleState(state: state, context: context);
          return TextButton(
              onPressed: () {
                BlocProvider.of<AccountBloc>(context)
                    .add(FetchAccountStarted());
              },
              child: Text("Retry"));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _button({required Widget child, required Function onPressed}) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              // color: Theme.of(context).buttonColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(standardBorderRadius))),
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: BlocBuilder(
            bloc: selectShippingAddressBloc,
            builder: (context, state) {
              return child;
            },
          )),
    );
  }
}
