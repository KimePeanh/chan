import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class NotificationState extends Equatable {
  NotificationState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchingNotification extends NotificationState {
  @override
  String toString() => 'LoadingFavouriteProcessing';
}

class FetchedNotification extends NotificationState {
  @override
  String toString() => 'AddingFavouriteProcessing';
}

class ErrorInitializingNotification extends NotificationState {
  final String error;
  ErrorInitializingNotification({required this.error});
  @override
  String toString() => 'LoadingFavouriteProcessing';
}

class ErrorFetchingNotification extends NotificationState {
  final String error;
  ErrorFetchingNotification({required this.error});
  @override
  String toString() => 'LoadingFavouriteProcessing';
}
