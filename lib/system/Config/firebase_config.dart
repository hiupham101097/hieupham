import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:qlcv/system/Config/exec_message.dart';
import 'package:qlcv/system/Config/notifi_config.dart';

import '../_base/model/content/global_model.dart';

class StartFirebase {
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    StartNotification.showRemoteMessage(message);
  }

  static Future<void> configFirebase(GlobalModel globalModal) async {
    FirebaseMessaging.onBackgroundMessage(
        StartFirebase.firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (Platform.isIOS) {
        FlutterAppBadger.updateBadgeCount(globalModal.timeLine! + 1);
      }
      StartNotification.showRemoteMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        FlutterAppBadger.removeBadge();
        ExecMessage.exec(message);
      },
    );
  }

  static Future<void> initFirebase(GlobalModel globalModel) async {
    var firebaseOption = Platform.isIOS
        // ignore: prefer_const_constructors
        ? FirebaseOptions(
            apiKey: "AIzaSyA--jzkdbJdddJ1AVhL28pofvGNhEXV5ok",
            appId: "1:580137525608:ios:945722f1a09e87705db6dd",
            messagingSenderId: "580137525608",
            projectId: "thongbao-net-vn-914c6",
            storageBucket: "thongbao-net-vn-914c6.appspot.com")
        // ignore: prefer_const_constructors
        : FirebaseOptions(
            apiKey: "AIzaSyC6056zcZBMtgt7CpRQehjNV-mmvLOIflg",
            appId: "1:580137525608:android:50bc67a936938c575db6dd",
            messagingSenderId: "580137525608",
            projectId: "thongbao-net-vn-914c6",
            storageBucket: "thongbao-net-vn-914c6.appspot.com");

    await Firebase.initializeApp(
      options: firebaseOption,
    );

    try {
      // ignore: unused_local_variable
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      await FirebaseMessaging.instance.setAutoInitEnabled(true);

      FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (Platform.isIOS) {
        FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
      }

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        sound: true,
        badge: true,
        alert: true,
      );

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      await FirebaseMessaging.instance.getToken().then(
        (String? token) async {
          globalModel.fireBaseToken = token;
        },
      );
      // ignore: empty_catches
    } catch (error) {}
  }

  static Future<String?> getAccessToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  static Future<RemoteMessage?> getMessage() {
    return FirebaseMessaging.instance.getInitialMessage();
  }
}
