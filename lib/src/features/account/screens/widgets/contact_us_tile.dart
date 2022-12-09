import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/account/bloc/contact/contact_bloc.dart';
import 'package:lady_skin/src/features/account/bloc/contact/contact_event.dart';
import 'package:lady_skin/src/features/account/bloc/contact/contact_state.dart';
import 'package:lady_skin/src/shared/widgets/error_snackbar.dart';
import 'package:lady_skin/src/shared/widgets/loading_dialogs.dart';

import 'contact_us_modal.dart';

Widget contactUs() => Builder(
      builder: (context) {
        return BlocListener<ContactBloc, ContactState>(
          listener: (context, state) {
            if (state is FetchingContact) {
              loadingDialogs(context);
            }
            if (state is ErrorFetchingContact) {
              Navigator.of(context).pop();
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is FetchedContact) {
              Navigator.of(context).pop();
              contactUsModal(context, state.contact);
            }
          },
          child: RaisedButton(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),

            // width: double.infinity,

            // padding: EdgeInsets.all(15),

            // decoration: BoxDecoration(

            //   borderRadius: BorderRadius.circular(5),

            //   color: Colors.red[100],

            // ),elevation: 0,

            onPressed: () {
              BlocProvider.of<ContactBloc>(context).add(FetchContact());
            },

            elevation: 0,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),

            color: Colors.white,

            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.translate("contactUs"),
                    textScaleFactor: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(

                        // letterSpacing: 0.5,

                        color: Theme.of(context).textTheme.headline1!.color),
                  ),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
          ),
        );
      },
    );
