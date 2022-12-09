import 'language_event.dart';
import 'language_state.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  @override
  LanguageBloc() : super(LanguageState(Locale("km", "KH")));

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is LanguageLoadStarted) {
      yield* _mapLanguageLoadStartedToState();
    } else if (event is LanguageSelected) {
      yield* _mapLanguageSelectedToState(event.languageCode!);
    }
  }

  Stream<LanguageState> _mapLanguageLoadStartedToState() async* {
    final storage = new FlutterSecureStorage();
    final lang = await storage.read(key: "lang");
    Locale locale;
    if (lang == null) {
      locale = Locale('en', 'US');
      await storage.write(key: "lang", value: "en");
    } else {
      if (lang == "en") {
        locale = Locale('en', 'US');
      } else {
        locale = Locale('km', 'KH');
      }
    }
    yield LanguageState(locale);
  }

  Stream<LanguageState> _mapLanguageSelectedToState(
      Language selectedLanguage) async* {
    final storage = new FlutterSecureStorage();

    final defaultLang = await storage.read(key: "lang");
    if (selectedLanguage == Language.KM) {
      yield* _loadLanguage('km', 'KH');
    } else if (selectedLanguage == Language.EN && defaultLang != "en") {
      yield* _loadLanguage('en', 'US');
    }
  }

  Stream<LanguageState> _loadLanguage(
      String languageCode, String countryCode) async* {
    final storage = new FlutterSecureStorage();
    final locale = Locale(languageCode, countryCode);
    await storage.write(key: "lang", value: languageCode);
    yield LanguageState(locale);
  }
}
