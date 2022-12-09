import 'package:equatable/equatable.dart';

abstract class BannerEvent extends Equatable {
  BannerEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchStarted extends BannerEvent {}
