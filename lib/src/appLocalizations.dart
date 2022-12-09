import 'package:flutter/material.dart';
import 'dart:convert';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  /// Helper method to keep the code in the widgets concise
  /// Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings = {};

  Future<bool> load() async {
    // final AssetBundle rootBundle = _initRootBundle();
    String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    try {
      String result = _localizedStrings[key]!;
      return result;
    } catch (e) {
      return "";
    }
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  // add all languages code here
  @override
  bool isSupported(Locale locale) {
    return ['en', 'km'].contains(locale.languageCode);
  }

  // load all localization files
  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
