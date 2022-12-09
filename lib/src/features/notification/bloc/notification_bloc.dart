import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/notification/models/my_notification.dart';
import 'package:lady_skin/src/features/notification/repositories/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  int page = 1;
  List<MyNotification> notificationList = [];
  NotificationRepository _categoryRepository = NotificationRepository();
  bool isRead = true;

  @override
  NotificationBloc() : super(FetchingNotification());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is SetReadingStatus) {
      yield FetchingNotification();
      await Future.delayed(Duration(milliseconds: 500));
      isRead = event.isRead;
      yield FetchedNotification();
    }
    if (event is InitializeNotification) {
      yield FetchingNotification();
      try {
        page = 1;
        notificationList =
            await _categoryRepository.getNotification(page: page);
        page++;
        yield FetchedNotification();
      } catch (e) {
        yield ErrorInitializingNotification(error: e.toString());
      }
    }
    if (event is FetchNotification) {
      yield FetchingNotification();
      try {
        await Future.delayed(Duration(milliseconds: 200));
        List<MyNotification> tempNotificationList =
            await _categoryRepository.getNotification(page: page);
        notificationList.addAll(tempNotificationList);
        page++;
        yield FetchedNotification();
      } catch (e) {
        yield ErrorFetchingNotification(error: e.toString());
      }
    }
  }
}
