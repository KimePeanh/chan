import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class BannerState extends Equatable {
  BannerState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchingBanner extends BannerState {}

class FetchedBanner extends BannerState {}

class ErrorFetchingBanner extends BannerState {
  final String error;
  ErrorFetchingBanner({required this.error});
}
