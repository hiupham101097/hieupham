import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:qlcv/system/Config/exec_message.dart';
import 'package:qlcv/system/Config/global_params.dart';

import '../../main.dart';

class StartNotification {
  static Future<void> configNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    var notificationsPlugin = GlobalParams.getLocalNotificationsPlugin();

    NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await notificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.didNotificationLaunchApp) {
      onTapLocalNotification(notificationAppLaunchDetails.notificationResponse);
    }

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onTapLocalNotification,
    );
  }

    static void requestPermission() {
    var notificationsPlugin = GetIt.instance<FlutterLocalNotificationsPlugin>();

    notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static void showRemoteMessage(RemoteMessage message) {
    _showNotification(
      message.hashCode,
      message.notification!.title,
      message.notification!.body,
      json.encode(
        {
          "title": message.notification!.title,
          "body": message.notification!.body,
          "data": json.encode(message.data)
        },
      ),
    );
  }

  static void showNotification(int hashCode, String? title, String? body) {
    notificationsPlugin.show(
      hashCode,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails('thongbao.net.vn', 'Thông báo',
            importance: Importance.high,
            enableVibration: true,
            playSound: true,
            icon: '@mipmap/ic_launcher',
            largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
            timeoutAfter: 1000),
        iOS: DarwinNotificationDetails(sound: 'slow_spring_board.aiff'),
      ),
    );
  }

  static void _showNotification(
    int hashCode,
    String? title,
    String? body,
    String payload,
  ) {
    var notificationsPlugin = GlobalParams.getLocalNotificationsPlugin();

    notificationsPlugin.show(
      hashCode,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'thongbao.net.vn',
          'Thông báo',
          importance: Importance.high,
          enableVibration: true,
          playSound: true,
          timeoutAfter: 1000,
        ),
        iOS: DarwinNotificationDetails(
          sound: 'slow_spring_board.aiff',
        ),
      ),
      payload: payload,
    );
  }

  static void onTapLocalNotification(
      NotificationResponse? notificationResponse) async {
    if (notificationResponse != null) {
      final String? payload = notificationResponse.payload;

      if (payload != null) {
        var mapValues = json.decode(payload);

        RemoteMessage message = RemoteMessage(
          notification: RemoteNotification(
            title: mapValues["title"],
            body: mapValues["body"],
          ),
          data: json.decode(mapValues["data"]),
        );

        ExecMessage.exec(message);
      }
    }
  }
}
