import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/login_register/bloc/register/register_bloc.dart';
import 'package:lady_skin/src/features/login_register/bloc/register/register_event.dart';
import 'package:lady_skin/src/features/login_register/bloc/register/register_state.dart';
import 'package:lady_skin/src/shared/widgets/error_snackbar.dart';
import 'package:lady_skin/src/shared/widgets/loading_dialogs.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is Registering) {
          loadingDialogs(context);
        } else if (state is Registered) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationStarted(token: state.token));
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else if (state is ErrorRegistering) {
          Navigator.of(context).pop();
          errorSnackBar(text: state.error, context: context);
        }
      },
      child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.translate("name")),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!
                      .translate("nameRequired");
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context)!.translate("phoneNumber")),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!
                      .translate("phoneNumberRequired");
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context)!.translate("password")),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!
                      .translate("passRequired");
                } else if (value.length < 8) {
                  return AppLocalizations.of(context)!
                      .translate("passwordLength");
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!
                      .translate("confirmPassword")),
              validator: (value) {
                if (value!.isEmpty || value != _passwordController.text) {
                  return AppLocalizations.of(context)!
                      .translate("falseConfirmPass");
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(standardBorderRadius),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<RegisterBloc>(context).add(
                          RegisterPressed(
                              name: _nameController.text,
                              phoneNumber: _phoneNumberController.text,
                              password: _passwordController.text));
                    }
                  },
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    AppLocalizations.of(context)!.translate("register"),
                    textScaleFactor: 1.2,
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ])),
    );
  }
}
