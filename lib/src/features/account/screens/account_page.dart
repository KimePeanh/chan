import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/account/bloc/contact/contact_bloc.dart';
import 'package:lady_skin/src/features/account/screens/widgets/my_favourite_tile.dart';

import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/account/bloc/index.dart';
import 'package:lady_skin/src/shared/widgets/login_button.dart';
import 'package:lady_skin/src/shared/widgets/register_button.dart';
import 'widgets/Information_tile.dart';

import 'widgets/address_tile.dart';
import 'widgets/contact_us_tile.dart';

import 'widgets/my_order_tile.dart';
import 'widgets/sign_out_tile.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          brightness: Brightness.dark,
          centerTitle: true,
          elevation: 0,
          // title: Text(
          //   AppLocalizations.of(context)!.translate('account'),
          //   textScaleFactor: 1.2,
          // ),
          // actions: [
          //   BlocBuilder<AuthenticationBloc, AuthenticationState>(
          //       builder: (context, state) {
          //     if (state is Authenticated) {
          //       return IconButton(
          //           color: Theme.of(context).primaryColor,
          //           icon: Icon(Icons.logout),
          //           onPressed: () {});
          //     }
          //     return Container();
          //   })
          // ],
        ),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (contextt, state) {
          if (state is Authenticated) {
            BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
            return BodyBuilder();
          } else if (state is NotAuthenticated) {
            //return Text("j");
            return Container(
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
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}

class BodyBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey _key = GlobalKey();

    return SingleChildScrollView(
        child: Column(
      children: [
        // AspectRatio(
        //   aspectRatio: 10 / 6,
        //   child: Row(
        //     children: [
        //       Expanded(

        //           ///user information
        //           flex: 1,
        //           child: Container(
        //             child: Column(
        //               children: [
        //                 Expanded(
        //                     child: informationTile(
        //                   context,
        //                 )),
        //                 // SizedBox(height: 15),
        //                 // Expanded(
        //                 //     //address
        //                 //     child: walletTile(context))
        //               ],
        //             ),
        //           )),
        //       SizedBox(width: 15),
        //       Expanded(
        //         flex: 1,
        //         child: Column(
        //           children: [
        //             Expanded(
        //                 //change pw
        //                 child: languageTile(context)),
        //             SizedBox(height: 15),
        //             Expanded(
        //                 //address
        //                 child: myFavouriteTile(
        //               context,
        //             ))
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        InformationTile(),

        myOrderTile(context),
        SizedBox(height: 25),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              Card(child: favouriteTile(context, key)),
              SizedBox(height: 10),
              Card(child: myAddressTile(context)),
              SizedBox(height: 10),
              Card(
                  child: BlocProvider(
                      create: (BuildContext context) {
                        return ContactBloc();
                      },
                      child: contactUs())),

              // SizedBox(height: 15),
              // aboutUsTile(context),

              // AspectRatio(aspectRatio: 10 / 1.5, child: signOutTile(context)),
            ],
          ),
        ),
        SizedBox(height: 25),
        signOutTile(context)
      ],
    ));
  }
}
