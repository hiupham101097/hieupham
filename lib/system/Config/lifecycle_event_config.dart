import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

import '../../main.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback? resumeCallBack;
  final AsyncCallback? suspendingCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          if (Platform.isIOS) {
            FlutterAppBadger.removeBadge();
          }
          await resumeCallBack!();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        statusMobile = "INACTIVE";
        if (suspendingCallBack != null) {
          if (Platform.isIOS) {
            FlutterAppBadger.removeBadge();
          }
          await suspendingCallBack!();
        }
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}
