import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:qlcv/system/_variables/value/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import '../../../system/Config/build_infomation.dart';
import '../../../system/_base/model/content/global_model.dart';
import '../../../system/user/user_data_component.dart';
import '../../home/home_view.dart';

// ignore: must_be_immutable
class LoginLayout extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  LoginLayout(
      GlobalModel? globalModel, BuildContext context, GlobalKey<FormState>? key)
      : globalModel = globalModel!,
        // ignore: prefer_initializing_formals
        context = context {
    viewKey = key;
  }
  GlobalKey<FormState>? viewKey;
  GlobalModel globalModel;
  BuildContext? context;
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _LoginLayout();
}

class _LoginLayout extends State<LoginLayout> {
  // ignore: unused_field
  String? _isCheck;
  Future<void> setToken(List<dynamic>? accestoken) async {
    var token = accestoken![0]["accessToken"];
    var enc = accestoken[0]["encryptedAccessToken"];
    var second = accestoken[0]["expireInSeconds"];
    globalModel.encryptToken = enc;
    globalModel.token = token;
    globalModel.timeLine = second;
    await UserDataComponent().setAppToken(token);
    await UserDataComponent().setEncrptedAuthToken(enc);
    await buildUserInfomation(token, globalModel);
    // ignore: use_build_context_synchronously
    await Navigator.of(context).push(
      HomeView.route(globalModel),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var userAgent = Platform.isIOS == true
        ? 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.1 Mobile/15E148 Safari/604.1'
        : 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
    final GlobalKey webViewKey = GlobalKey();
    // ignore: unused_local_variable
    InAppWebViewController? webViewController;
    // ignore: deprecated_member_use
    InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
        // ignore: deprecated_member_use
        crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
        ),
        // ignore: deprecated_member_use
        android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
        ),
        // ignore: deprecated_member_use
        ios: IOSInAppWebViewOptions(
          allowsInlineMediaPlayback: true,
        ));
    return Scaffold(
        body: Center(
      child: InAppWebView(
        key: webViewKey,
        initialUrlRequest:
            URLRequest(url: Uri.parse("${AppConst.apiSSO}/web-view/login")),
        // ignore: deprecated_member_use
        initialOptions: options,
        onWebViewCreated: (controller) async {
          webViewController = controller;
          controller.addJavaScriptHandler(
            handlerName: 'getTokenFromWeb',
            callback: (args) async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                "SETTOKEN",
                "false",
              );
              setToken(args);
            },
          );
          final prefs = await SharedPreferences.getInstance();
          // ignore: unused_local_variable
          var value = prefs.getString(
            "SETTOKEN",
          );
        },
      ),
    ));
  }
}
