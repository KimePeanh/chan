import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/account/bloc/index.dart';
import 'package:lady_skin/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:lady_skin/src/features/authentication/bloc/authentication_state.dart';
import 'package:lady_skin/src/shared/widgets/login_button.dart';
import 'package:lady_skin/src/shared/widgets/register_button.dart';

import 'widgets/account_setting.dart';
import 'widgets/app_setting.dart';
import 'widgets/more_setting.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: settingAppBar(context),
      body: Container(
          padding: EdgeInsets.all(15),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            if (state is Authenticating) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NotAuthenticated) {
              return Column(
                children: [
                  loginButton(context: context),
                  SizedBox(
                    height: 15,
                  ),
                  registerButton(context: context)
                ],
              );
            }
            BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
            return SingleChildScrollView(
              child: Column(
                children: [
                  accountSetting(context: context),
                  SizedBox(height: 30),
                  appSetting(context: context),
                  SizedBox(height: 30),
                  moreSetting(context: context),
                ],
              ),
            );
          })),
    );
  }
}
