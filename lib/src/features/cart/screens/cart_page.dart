import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/cart/bloc/index.dart';
import 'package:lady_skin/src/shared/widgets/loading_dialogs.dart';
import 'package:lady_skin/src/shared/widgets/login_button.dart';
import 'package:lady_skin/src/shared/widgets/register_button.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';

import 'widgets/cart_detail_frame.dart';
import 'widgets/cart_product_tile.dart';

class CartPageWrapper extends StatefulWidget {
  final isNavigated;
  CartPageWrapper({this.isNavigated = false});
  @override
  _CartPageWrapperState createState() => _CartPageWrapperState();
}

class _CartPageWrapperState extends State<CartPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: (widget.isNavigated)
              ? IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.arrow_back_outlined),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              : Container(),
          backgroundColor: Theme.of(context).primaryColor,
          brightness: Brightness.dark,
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.translate("cart"),
            style: TextStyle(
              color: Colors.white,
            ),
            textScaleFactor: 1.2,
          ),
        ),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (BuildContext context, state) {
            if (state is Authenticated) {
              return CartPage();
            } else if (state is NotAuthenticated) {
              return Container(
                // color: Colors.yellow,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginButton(context: context),
                    SizedBox(height: 15),
                    registerButton(context: context),
                  ],
                ),
              );
              // AuthenticationButton();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    BlocProvider.of<CartBloc>(context).add(FetchCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        builder: (BuildContext context, state) {
      // Helper.handleState(state: state, context: context);
      if (state is FetchingCart) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ErrorFetchingCart) {
        Helper.handleState(state: state, context: context);
        return Container(
          child: Text(state.error),
        );
      } else {
        if (BlocProvider.of<CartBloc>(context).cart.data.length == 0) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.width / 3.5,
                  child: FittedBox(
                      child: Icon(Icons.shopping_cart_outlined,
                          color: Colors.grey[300]))),
              SizedBox(height: 20),
              Text("Empty cart!", style: TextStyle(color: Colors.grey[400]))
            ],
          ));
        }
        return Scaffold(
          body: Column(
            children: [
              //SelectShippingAddressBtn(),
              Expanded(
                child: BlocListener<CartBloc, CartState>(
                  listener: (context, state) {
                    // Helper.handleState(state: state, context: context);
                    if (state is ProccessingCart) {
                      loadingDialogs(context);
                    }
                    if (state is ProccessedCart ||
                        state is ErrorCart ||
                        state is ErrorFetchingCart) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: BlocProvider.of<CartBloc>(context)
                                .cart
                                .data
                                .length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CartProductTile(
                                cartData: BlocProvider.of<CartBloc>(context)
                                    .cart
                                    .data[index],
                              );
                            },
                          ),
                          AspectRatio(
                            aspectRatio: 7 / 1.8,
                            child: Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              CartDetailFrame(
                  total: BlocProvider.of<CartBloc>(context).cart.total,
                  btnText: AppLocalizations.of(context)!.translate("continue"),
                  onBtnPressed: () {
                    Navigator.pushNamed(context, checkout);
                  }),
            ],
          ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: CartDetailFrame(
          //   user: widget.user,
          // )
        );
      }
    });
  }
}
