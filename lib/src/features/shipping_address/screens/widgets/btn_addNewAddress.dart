import 'package:flutter/material.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';
import '../address_form_page.dart';

class BtnAddNewAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressFormPage()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(standardBorderRadius)),
                padding: EdgeInsets.all(0.0),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!
                        .translate('addNewAddress')
                        .toUpperCase(),
                    textScaleFactor: 1.2,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, letterSpacing: 0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
