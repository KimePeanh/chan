import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/login_register/screens/login_register_page.dart';

class RequireLogin extends StatelessWidget {
  RequireLogin({required this.widget});
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (c, s) {
      if (s is NotAuthenticated) {
        return LoginRegisterPage();
      }
      return this.widget;
    });
  }
}
