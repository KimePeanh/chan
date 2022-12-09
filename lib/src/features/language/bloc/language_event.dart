import 'package:equatable/equatable.dart';
import 'language_state.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class LanguageLoadStarted extends LanguageEvent {}

class LanguageSelected extends LanguageEvent {
  final Language? languageCode;

  LanguageSelected(this.languageCode) : assert(languageCode != null);

  @override
  List<Object> get props => [languageCode!];
}
