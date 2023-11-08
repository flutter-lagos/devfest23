import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final class LocalNotificationManager {
  static Future<void> initialiseHeadsUpNotificationAndroid() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);
  }

  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  static const _initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  static const _initializationSettingsDarwin = DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void showNotification(NotificationDto message) {
    _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: _initializationSettingsAndroid,
        iOS: _initializationSettingsDarwin,
      ),
    );

    _flutterLocalNotificationsPlugin.show(
      message.id,
      message.title,
      message.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          priority: Priority.high,
          importance: _androidChannel.importance,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          badgeNumber: 0,
          attachments: null,
        ),
      ),
    );
  }
}

final class NotificationDto extends Equatable {
  final int id;
  final String? title;
  final String? body;

  const NotificationDto({required this.id, this.title, this.body});

  @override
  List<Object?> get props => [id, title, body];
}
