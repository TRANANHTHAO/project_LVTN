import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  String channelNotification = 'eRentacarChannelNotify-1';
  String nameNotification = 'eRentacarChannel';
  String descriptionNotification = 'eRentacar channel';

  NotificationService() {
    initLocalNotification();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void initLocalNotification() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const android = AndroidInitializationSettings('mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      // onSelectNotification: onSelectNotification,
    );
  }

  Future<void> onDidReceiveNotificationResponse(
      NotificationResponse? payload,
      ) async {
    if (payload != null) {
      print('[onSelectNotification][payload]: ${payload.payload}');
    }
  }

  Future<void> showLocalNotification(String title, String body) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelNotification,
      nameNotification,
      channelDescription: descriptionNotification,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final random = Random();
    final randomNumber = random.nextInt(9999);

    final id = randomNumber;

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: 'payload',
    );
  }
}
