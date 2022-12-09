import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/change_password/bloc/index.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';

import '../../../../appLocalizations.dart';

class ChangeChangePasswordForm extends StatefulWidget {
  @override
  _ChangeChangePasswordFormState createState() =>
      _ChangeChangePasswordFormState();
}

class _ChangeChangePasswordFormState extends State<ChangeChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _currentChangePasswordController = TextEditingController();
  final _newChangePasswordController = TextEditingController();
  final _comfirmNewChangePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //  final width = MediaQuery.of(context).size.width / 1.2;
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.translate("changePassword"),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0),
              textScaleFactor: 1.8,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _currentChangePasswordController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context)!.translate('currentPassword'),
                //  filled: true,
                isDense: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!
                      .translate('inpCurrentPass');
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _newChangePasswordController,
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context)!.translate('newPassword'),
                // filled: true,
                isDense: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!
                      .translate('newPassRequired');
                } else {
                  if (value.length < 8) {
                    return AppLocalizations.of(context)!
                        .translate('passwordLength');
                  }
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!
                      .translate('comfirmNewPassword'),
                  //  filled: true,
                  isDense: true,
                ),
                obscureText: true,
                controller: _comfirmNewChangePasswordController,
                validator: (value) {
                  if (value!.isNotEmpty &&
                      _newChangePasswordController.value.text.isNotEmpty) {
                    if (value != _newChangePasswordController.value.text) {
                      return AppLocalizations.of(context)!
                          .translate('falseConfirmNewPass');
                    }
                  } else if (value.isEmpty &&
                      _newChangePasswordController.value.text.isNotEmpty) {
                    return AppLocalizations.of(context)!
                        .translate('comfirmNewPass');
                  }
                  return null;
                }),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 10),
              child: SizedBox(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(standardBorderRadius)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<ChangePasswordBloc>(context)
                          .add(ChangePasswordButtonPressed(
                        currentChangePassword:
                            _currentChangePasswordController.text,
                        newChangePassword: _newChangePasswordController.text,
                      ));
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!
                        .translate("changePassword")
                        .toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w400),
                    textScaleFactor: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
