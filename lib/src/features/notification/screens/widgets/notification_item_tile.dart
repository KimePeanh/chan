import 'package:flutter/material.dart';
import 'package:lady_skin/src/features/notification/models/my_notification.dart';
import 'package:lady_skin/src/utils/services/notification_navigator.dart';

class NotificationItemTile extends StatelessWidget {
  final MyNotification notification;
  NotificationItemTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        notificationNavigator(context,
            target: notification.target, targetValue: notification.targetValue);
      },
      child: Container(
        width: double.infinity,
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.title,
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              notification.body,
              style: Theme.of(context).textTheme.bodyText2,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
