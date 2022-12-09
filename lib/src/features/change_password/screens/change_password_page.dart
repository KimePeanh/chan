import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/change_password/bloc/index.dart';
import 'package:lady_skin/src/shared/widgets/error_snackbar.dart';
import 'package:lady_skin/src/shared/widgets/loading_dialogs.dart';
import 'widgets/change_password_form.dart';

class ChangeChangePasswordPage extends StatefulWidget {
  @override
  _ChangeChangePasswordPageState createState() =>
      _ChangeChangePasswordPageState();
}

class _ChangeChangePasswordPageState extends State<ChangeChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChangePasswordBloc(),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
                color: Colors.black,
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          body: Body()),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, ChangePasswordState state) {
        if (state is Changing) {
          loadingDialogs(context);
        }
        if (state is ChangeFailed) {
          Navigator.of(context).pop();
          errorSnackBar(text: state.error, context: context);
        }
        if (state is Changed) {
          void _popupDialog(BuildContext context) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Succed'),
                    content: Text('Your password has been changed'),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('OK')),
                    ],
                  );
                });
          }

          Navigator.of(context).pop();
          String _token = state.accessToken;
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationStarted(token: _token));
          _popupDialog(context);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [ChangeChangePasswordForm()],
        ),
      ),
    );
  }
}
