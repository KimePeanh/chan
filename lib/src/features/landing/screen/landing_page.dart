import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/app/screens/app_page.dart';
import 'package:lady_skin/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/notification/bloc/index.dart';
import 'package:lady_skin/src/features/notification/bloc/notification_bloc.dart';
import 'package:lady_skin/src/features/splash/screens/splash_page.dart';
import 'package:lady_skin/src/utils/services/notification_navigator.dart';
import 'package:firebase_core/firebase_core.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    notificationNavigator(context,
        target: message.data["target"],
        targetValue: message.data["target_value"]);
    print("Handling a background message");
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (c) => NotificationPage()));
  }

  initNotification() async {
    Firebase.initializeApp().then((value) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      messaging.requestPermission();
      messaging.subscribeToTopic("all").then((value) {
        messaging
            .setForegroundNotificationPresentationOptions(
                alert: true, badge: true, sound: true)
            .then((value) {
          String? token;

          messaging.getToken().then((value) {
            token = value;
            print("token" + token.toString());
            FirebaseMessaging.instance.getInitialMessage().then((message) {
              print("FirebaseMessaging.getInitialMessage");
              if (message != null) {
                print(message);
                notificationNavigator(context,
                    target: message.data["target"],
                    targetValue: message.data["target_value"]);
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (c) => NotificationPage()));
              }
            });
            FirebaseMessaging.onBackgroundMessage(
                firebaseMessagingBackgroundHandler);
            FirebaseMessaging.onMessage.listen((RemoteMessage message) {
              BlocProvider.of<NotificationBloc>(context)
                  .add(SetReadingStatus(isRead: false));
            });

            FirebaseMessaging.onMessageOpenedApp
                .listen(firebaseMessagingBackgroundHandler);
          });
        });
      });
    });
  }

  @override
  void initState() {
    initNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      print(state);
      if (state is Initializing) {
        return SplashPage();
      }
      return AppPage();
    });
  }
}
