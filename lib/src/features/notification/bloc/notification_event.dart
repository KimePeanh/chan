import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  NotificationEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchNotification extends NotificationEvent {}

class InitializeNotification extends NotificationEvent {}

class SetReadingStatus extends NotificationEvent {
  final bool isRead;
  SetReadingStatus({required this.isRead});
}
