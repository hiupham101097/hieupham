import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

GetIt globalGetIt = GetIt.instance;

class GlobalParams {
  static FlutterLocalNotificationsPlugin getLocalNotificationsPlugin() {
    if (globalGetIt.isRegistered<FlutterLocalNotificationsPlugin>() == false) {
      globalGetIt.registerSingleton<FlutterLocalNotificationsPlugin>(
          FlutterLocalNotificationsPlugin(),
          signalsReady: true);
    }

    return globalGetIt<FlutterLocalNotificationsPlugin>();
  }

  static GlobalKey<NavigatorState> getGlobalKeyNavigatorState() {
    if (globalGetIt.isRegistered<GlobalKey<NavigatorState>>() == false) {
      globalGetIt.registerSingleton<GlobalKey<NavigatorState>>(
          GlobalKey<NavigatorState>(),
          signalsReady: true);
    }

    return globalGetIt<GlobalKey<NavigatorState>>();
  }
}
