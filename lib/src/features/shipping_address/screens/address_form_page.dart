import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/shipping_address/bloc/index.dart';
import 'package:lady_skin/src/features/shipping_address/bloc/shipping_address_state.dart';
import 'package:lady_skin/src/shared/widgets/error_snackbar.dart';
import 'package:lady_skin/src/shared/widgets/loading_dialogs.dart';
import 'package:flutter/cupertino.dart';

import 'shipping_address_page.dart';
import 'widgets/address_detail_field.dart';
import 'widgets/btn_choose_locaion.dart';
// import 'widgets/form/form.dart' as widget;
import 'package:lady_skin/src/utils/helper/helper.dart';

class AddressFormPage extends StatefulWidget {
  AddressFormPage();
  @override
  AddressFormPageState createState() => AddressFormPageState();
}

class AddressFormPageState extends State<AddressFormPage> {
  static final TextEditingController addressDetailTextController =
      TextEditingController();
  static String lat = "";
  static String long = "";
  static String city = "";

  // static AddressFormBloc addressFormBloc = AddressFormBloc();
  @override
  void initState() {
    addressDetailTextController.text = "";
    lat = "";
    long = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          PreferredSize(preferredSize: Size.fromHeight(56), child: appBar()),
      body: BlocListener(
        bloc: shippingAddressBloc,
        listener: (context, state) {
          if (state is ProcessingAddress) {
            loadingDialogs(context);
          }
          if (state is ProcessedAddress) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
          if (state is ErrorProcessingAddress) {
            Helper.handleState(state: state, context: context);
            Navigator.pop(context, true);
            errorSnackBar(text: state.error, context: context);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 0),
                alignment: Alignment.topLeft,
                child: Text(
                  AppLocalizations.of(context)!.translate('addNewAddress'),
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
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: AspectRatio(
                      aspectRatio: 7 / 4, child: addressDetailField(context))),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: AspectRatio(
                      aspectRatio: 9 / 1.6, child: btnChooseLocation())),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // addressFormBloc.close();
    super.dispose();
  }
}

Widget appBar() => Builder(
    builder: (context) => AppBar(
          brightness: Brightness.light,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.red[300],
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.blue[300],
              ),
              onPressed: () {
                if (AddressFormPageState.lat.length == 0) {
                  // CoolAlert.show(
                  //     title: "Please choose location",
                  //     context: context,
                  //     type: CoolAlertType.info);
                } else {
                  shippingAddressBloc.add(AddAddressStarted(
                      name: "1",
                      lat: AddressFormPageState.lat,
                      long: AddressFormPageState.long,
                      description: AddressFormPageState
                              .addressDetailTextController.text +
                          " (${AddressFormPageState.city})"));
                }
              },
            )
          ],
        ));
