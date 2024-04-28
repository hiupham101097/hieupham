import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:qlcv/main.dart';
import 'package:qlcv/system/Config/global_params.dart';
import 'package:qlcv/system/_variables/value/app_const.dart';
import 'package:qlcv/view/webview/web_view.dart';

class ExecMessage {
  static void exec(RemoteMessage message) {
    var navigatorKey = GlobalParams.getGlobalKeyNavigatorState();

    if (navigatorKey.currentState != null) {
      var data = message.data["conversation"];
      var jsonData = json.decode(data);
      var groupId = jsonData["groupId"];
      Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: (context) => AppWebView(
                  globalModel: globalModel,
                  // ignore: prefer_interpolation_to_compose_strings
                  url: '${AppConst.urlQLCV}/web-view/chat1?key=' + groupId,
                  title: "message",
                  checkChat: "chat",
                )),
      );
    }
  }

  static List<Widget> getValues(RemoteMessage? message) {
    List<Widget> values = [];

    if (message != null) {
      if (message.notification != null) {
        values.add(Text(message.notification!.body ?? ""));
      }
      values.add(Text(message.data["sender"]));
      values.add(Text(message.data["messageId"]));
      values.add(Text(message.data["channelId"]));
    } else {
      values.add(const Text("Content"));
    }

    return values;
  }
}
