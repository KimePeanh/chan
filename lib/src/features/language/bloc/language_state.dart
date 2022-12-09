import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

enum Language { EN, KM }

class LanguageState extends Equatable {
  final Locale? locale;
  const LanguageState(this.locale) : assert(locale != null);

  @override
  List<Object> get props => [locale!];
}
