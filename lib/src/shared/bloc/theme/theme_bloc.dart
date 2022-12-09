import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lady_skin/src/config/themes/app_theme.dart';

import 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  @override
  ThemeBloc() : super(appThemeData[AppTheme.Light]!);

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeChange) {
      yield appThemeData[event.theme]!;
    }
  }
}
