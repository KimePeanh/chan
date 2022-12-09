import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/account/bloc/account_bloc.dart';
import 'package:lady_skin/src/features/account/bloc/index.dart';
import 'package:lady_skin/src/features/account/models/user.dart';

import 'package:lady_skin/src/features/shipping_address/bloc/index.dart';

import 'package:lady_skin/src/shared/widgets/error_snackbar.dart';
import 'package:lady_skin/src/shared/widgets/standard_appbar.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';

import 'widgets/btn_addNewAddress.dart';
import 'widgets/shipping_address_item_tile.dart';

late ShippingAddressBloc shippingAddressBloc;

class ShippingAddressPage extends StatefulWidget {
  final bool isView;
  ShippingAddressPage({this.isView = true});

  @override
  _ShippingAddressPageState createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  @override
  void initState() {
    shippingAddressBloc = ShippingAddressBloc();
    shippingAddressBloc.add(FetchAddressListStarted());
    super.initState();
  }

  @override
  void dispose() {
    shippingAddressBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: standardAppBar(context, ""),
        body: Body(
          isView: widget.isView,
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: BtnAddNewAddress());
  }
}

class Body extends StatelessWidget {
  final bool isView;
  Body({required this.isView});
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: shippingAddressBloc,
      listener: (context, state) {
        if (state is ErrorFetchingAddressList) {
          Helper.handleState(state: state, context: context);
          errorSnackBar(text: state.error, context: context);
        }
        if (state is SetDefaultAddressSucess) {
          if (BlocProvider.of<AccountBloc>(context).state is FetchedAccount) {
            final User _user =
                BlocProvider.of<AccountBloc>(context).state.user!;
            _user.address = state.address;
            BlocProvider.of<AccountBloc>(context).add(SetAccount(user: _user));
          }
        }
      },
      child: BlocBuilder(
          bloc: shippingAddressBloc,
          builder: (context, ShippingAddressState state) {
            if (state is FetchingAddressList) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!
                            .translate('shippingAddresses'),
                        // AppLocalizations.of(context)!.translate('shippingAddress'),
                        //AppLocalizations.of(context)!.translate("language"),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                        textScaleFactor: 1.8,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: shippingAddressBloc.addressList.length,
                            itemBuilder: (context, index) {
                              return ShippingAddressItemTile(
                                isView: this.isView,
                                index: index,
                              );
                            }),
                        AspectRatio(
                          aspectRatio: 10 / 2,
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
