import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/login_register/bloc/login/login_bloc.dart';
import 'package:lady_skin/src/features/login_register/bloc/register/register_bloc.dart';
import 'package:lady_skin/src/features/login_register/screens/widgets/login_form.dart';

import 'widgets/logo_holder.dart';
import 'widgets/register_form.dart';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage({this.isLogin = true});
  final bool isLogin;
  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  late bool isLogin;
  @override
  void initState() {
    isLogin = widget.isLogin;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),
        BlocProvider<RegisterBloc>(
            create: (BuildContext context) => RegisterBloc())
      ],
      child: Scaffold(
        appBar: AppBar(
          brightness: Theme.of(context).brightness,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: ListView(
            children: [
              logoHolder(),
              SizedBox(
                height: 25,
              ),
              isLogin
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(
                            AppLocalizations.of(context)!.translate("logIn"),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textScaleFactor: 2,
                          ),
                          SizedBox(height: 20),
                          LoginForm(),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isLogin = false;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppLocalizations.of(context)!
                                    .translate("newUser?")),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .translate("register"),
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ])
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(
                            AppLocalizations.of(context)!.translate("register"),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textScaleFactor: 2,
                          ),
                          SizedBox(height: 20),
                          RegisterForm(),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isLogin = true;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppLocalizations.of(context)!
                                    .translate("haveAccount?")),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .translate("logIn"),
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ])
            ],
          ),
        ),
      ),
    );
  }
}
