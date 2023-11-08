import 'package:devfest23/core/services/local_notification_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebaseNotificationManager {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// Define a top-level named handler which background/terminated messages will call.
  /// To verify things are working, check out the native platform logs.
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
  }

  Future<void> registerNotification() async {
    await Firebase.initializeApp();
    messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        debugPrint('Notification Messages: ${message.data.toString()}');
      } else {
        debugPrint('Empty Messages: $message');
      }
    });
    await LocalNotificationManager.initialiseHeadsUpNotificationAndroid();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // request permission from user to display notification
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    /// Check if Permission to request Notification has been granted
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          // Set Notification Message Object
          NotificationDto notificationMessage = NotificationDto(
            id: notification.hashCode,
            title: notification.title,
            body: notification.body,
          );

          // Call Notification Manager to show Notification
          LocalNotificationManager.showNotification(notificationMessage);
        }
      });
    }
  }

  Future<String?> get deviceToken async {
    return await messaging.getToken();
  }
}
