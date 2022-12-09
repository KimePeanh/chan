import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/cart/bloc/index.dart';

Widget signOutTile(context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: RaisedButton(
        // width: double.infinity,

        // padding: EdgeInsets.all(15),

        // decoration: BoxDecoration(

        //   borderRadius: BorderRadius.circular(5),

        //   color: Colors.red[100],

        // ),

        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),

        elevation: 0,

        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  title: Text(
                      AppLocalizations.of(context)!.translate('logOutPrompt')),
                  content: Text(AppLocalizations.of(context)!
                      .translate('logOutQuestion')),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(
                          AppLocalizations.of(context)!.translate('cancel')),
                    ),
                    FlatButton(
                      onPressed: () {
                        // SystemChannels.platform

                        //     .invokeMethod('SystemNavigator.pop');

                        Navigator.of(context).pop(false);

                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LogoutPressed());

                        BlocProvider.of<CartBloc>(context).add(LogoutCart());
                      },
                      child: Text(
                          AppLocalizations.of(context)!.translate('logOut'),
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                );
              });
        },

        //color: Colors.red[200],

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),

        child: Center(
          child: Text(
            AppLocalizations.of(context)!.translate("logOut"),
            textScaleFactor: 1.1,
            style: TextStyle(
              //letterSpacing: 0.5,

              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
