import 'package:equatable/equatable.dart';
import 'package:lady_skin/src/config/themes/app_theme.dart';

abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class ThemeChange extends ThemeEvent {
  ThemeChange({required this.theme});
  final AppTheme theme;
}
