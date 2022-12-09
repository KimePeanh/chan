// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:lady_skin/main.dart';
// import 'package:lady_skin/src/features/notification/screens/notification_page.dart';

// class PushNotificationsService {
//   Future init() async {
//     await Firebase.initializeApp();

//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     messaging.requestPermission();
//     await messaging.subscribeToTopic("all");
//     await messaging.setForegroundNotificationPresentationOptions(
//         alert: true, badge: true, sound: true);
//     String? token = (await messaging.getToken());
//     print("token" + token.toString());
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       print("FirebaseMessaging.getInitialMessage");
//       if (message != null) {
//         print(message);
//         AppInitializer.navigatorKey.currentState!
//             .push(MaterialPageRoute(builder: (c) => NotificationPage()));
//       }
//     });
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print(message.notification!.body);
//       print(message.notification.toString());
//       print(message);
//       AppInitializer.navigatorKey.currentState!
//           .push(MaterialPageRoute(builder: (c) => NotificationPage()));
//     });

//     FirebaseMessaging.onMessageOpenedApp
//         .listen(firebaseMessagingBackgroundHandler);
//     // var result = await FlutterNotificationChannel.registerNotificationChannel(
//     //   description: 'Your channel description',
//     //   id: 'default',
//     //   importance: NotificationImportance.IMPORTANCE_HIGH,
//     //   name: 'default',
//     //   visibility: v.NotificationVisibility.VISIBILITY_PUBLIC,
//     //   allowBubbles: true,
//     //   enableVibration: true,
//     //   enableSound: true,
//     //   showBadge: true,
//     // );
//     // print(result);
//   }
// }

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message");
//   AppInitializer.navigatorKey.currentState!
//       .push(MaterialPageRoute(builder: (c) => NotificationPage()));
// }
