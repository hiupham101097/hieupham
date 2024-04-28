import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qlcv/main.dart';
import 'package:qlcv/system/_base/model/content/bloc_status.dart';
import 'package:qlcv/view/webview/web_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/controller/home/home_bloc.dart';
import '../../../base/controller/home/home_state.dart';
import '../../../system/_base/model/content/global_model.dart';
import '../../../system/_variables/value/app_style.dart';
import '../../../system/_variables/value/text_app_data.dart';
import '../../menu/menu_view.dart';
import '../home_view.dart';

// ignore: must_be_immutable
class HomeLayout extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  HomeLayout(GlobalModel? globalModel, GlobalKey<FormState>? key)
      : _globalModel = globalModel,
        super() {
    key = viewKey;
  }
  final GlobalModel? _globalModel;
  GlobalKey<FormState>? viewKey;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() =>
      // ignore: no_logic_in_create_state
      _HomeLayout(_globalModel);
}

class _HomeLayout extends State<HomeLayout> {
  _HomeLayout(GlobalModel? globalModel) {
    _globalModel = globalModel!;
  }
  late GlobalModel _globalModel;
  final GlobalKey webViewKey = GlobalKey();
  String? checkChat;
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useOnDownloadStart: true,
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));
  double progress = 0;
  bool checkView = false;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Future<bool> _willPopCallback(String? url) async {
      bool canNavigate = await webViewController!.canGoBack();
      if (canNavigate) {
        checkView = false;
        webViewController!.goBack();
        return false;
      } else {
        // ignore: use_build_context_synchronously
        SystemNavigator.pop();
        return true;
      }
    }

    var authToken =
        Uri.encodeComponent(globalModel.token!.replaceAll("Bearer", "").trim());
    // ignore: unused_local_variable
    var tenant = globalModel.userDataModal.tenant!.id;
    var encAuthToken = Uri.encodeComponent(globalModel.encryptToken.trim());

    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      var link = globalModel.listUrl!
          .where((w) => w.code!.contains("HOMEQLCV"))
          .firstOrNull;
      var congViec = _globalModel.menus!
          .where((w) => w.codeData!.contains("CONGVIEC"))
          .first;
      var checkAg = false;
      switch (state.status) {
        case StatusWidget.failure:
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: AppStyle.colors[0][4],
              title:
                  // ignore: avoid_unnecessary_containers
                  Container(
                      //margin: EdgeInsets.fromLTRB(0, 0, 130, 0),
                      child: Text(TextAppData.getValue("home"))),
            ),
            drawer: Drawer(
                child: MenuView(
              globalModel: globalModel,
            )),
            body: Container(
              padding: const EdgeInsets.only(top: 50),
              // ignore: prefer_const_constructors
              child: Column(
                children: const [
                  Center(child: Text("kết nối gặp lỗi, Vui lòng chờ đợi")),
                  Center(child: CircularProgressIndicator())
                ],
              ),
            ),
          );
        case StatusWidget.success:
          return WillPopScope(
            onWillPop: () => _willPopCallback(link.url),
            child: Scaffold(
              appBar: AppBar(
                elevation: 1,
                backgroundColor: AppStyle.colors[0][4],
                title:
                    // ignore: avoid_unnecessary_containers
                    Container(
                        //margin: EdgeInsets.fromLTRB(0, 0, 130, 0),
                        child: Text(TextAppData.getValue("home"))),
              ),
              drawer: Drawer(
                child: MenuView(
                  globalModel: globalModel,
                ),
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Stack(
                      children: [
                        InAppWebView(
                          key: webViewKey,
                          // ignore: deprecated_member_use
                          initialOptions: options,
                          initialUrlRequest:
                              URLRequest(url: Uri.parse(link!.url.toString())),
                          // initialOptions: options,
                          onWebViewCreated: (controller) async {
                            webViewController = controller;

                            final prefs = await SharedPreferences.getInstance();
                            // ignore: unused_local_variable
                            var value = prefs.getString(
                              "SETTOKEN",
                            );
                            controller.addJavaScriptHandler(
                              handlerName: 'mobileListener',
                              callback: (args) async {
                                // ignore: avoid_print
                                print(args);
                                if (args.isNotEmpty) {
                                  if (checkView == false) {
                                    if (args[0] == 'task') {
                                      checkView = true;
                                      Navigator.of(context)
                                          .push(AppWebView.route(
                                              globalModel,
                                              congViec.name,
                                              congViec.valueData.toString(),
                                              "task"))
                                          .then((value) => checkView = false);
                                    }
                                    if (args[0] == 'message') {
                                      checkView = true;

                                      var urlChat = globalModel.listUrl!
                                          .where((w) =>
                                              w.code!.contains("LISTCHATQLCV"))
                                          .firstOrNull;
                                      Navigator.of(context)
                                          .push(AppWebView.route(
                                              globalModel,
                                              TextAppData.getValue("groups"),
                                              urlChat!.url,
                                              "task"))
                                          .then((value) => checkView = false);
                                    }
                                    if (globalModel.listGroup!
                                        .where((e) => args[0].contains(e.name))
                                        .isNotEmpty) {
                                      checkView = true;

                                      if (checkAg == false) {
                                        checkAg = true;

                                        var dataLink = args[0];
                                        var link = globalModel.listUrl!
                                            .where((w) =>
                                                w.code!.contains("INBOXQLCV"))
                                            .firstOrNull;
                                        var url = link!.url! + dataLink[0];
                                        await Navigator.of(context)
                                            .push(
                                          AppWebView.route(_globalModel, 'chat',
                                              url, "chat"),
                                        )
                                            .then((value) async {
                                          checkAg = false;
                                          await Navigator.of(context)
                                              .push(
                                                HomeView.route(globalModel),
                                              )
                                              .then(
                                                  (value) => checkView = false);
                                        });
                                      }
                                    }
                                  } else {
                                    if (globalModel.listGroup!
                                        .where((e) => e.name!.contains(args[0]))
                                        .isNotEmpty) {
                                      checkView = true;

                                      if (checkAg == false) {
                                        checkAg = true;

                                        var dataLink = args[0];
                                        var link = globalModel.listUrl!
                                            .where((w) =>
                                                w.code!.contains("INBOXQLCV"))
                                            .firstOrNull;
                                        var url = link!.url! + dataLink[0];
                                        await Navigator.of(context)
                                            .push(
                                          AppWebView.route(_globalModel, 'chat',
                                              url, "chat"),
                                        )
                                            .then((value) async {
                                          checkAg = false;
                                          await Navigator.of(context)
                                              .push(
                                                HomeView.route(globalModel),
                                              )
                                              .then(
                                                  (value) => checkView = false);
                                        });
                                      }
                                    }
                                  }
                                }
                                // ignore: unused_local_variable
                                var isCheck = false;
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString("SETTOKEN", "false");
                              },
                            );
                          },
                          onLoadStop: ((controller, url) async {
                            final prefs = await SharedPreferences.getInstance();
                            var value = prefs.getString(
                              "SETTOKEN",
                            );

                            // ignore: unrelated_type_equality_checks
                            if (value == null || value == "false") {
                              controller.evaluateJavascript(
                                source:
                                    'mobileSetCookie("$authToken", "$encAuthToken", 3600);',
                              );
                            }
                          }),
                          // shouldOverrideUrlLoading: (controller, navigationAction) {
                          // },
                          onDownloadStartRequest:
                              (controller, downloadStartRequest) async {
                            // Plugin must be initialized before using
                            var hasStoragePermission =
                                await Permission.storage.isGranted;
                            if (!hasStoragePermission) {
                              final status = await Permission.storage.request();
                              hasStoragePermission = status.isGranted;
                            }
                          },
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          );

        default:
          return Scaffold(
            backgroundColor: AppStyle.colors[0][4],
            appBar: AppBar(
                elevation: 1,
                backgroundColor: AppStyle.colors[0][4],
                title: Text(
                  TextAppData.getValue("home"),
                )),
            drawer: Drawer(
                child: MenuView(
              globalModel: globalModel,
            )),
            body: Card(
              color: AppStyle.colors[0][4],
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                itemCount: 1,
                itemBuilder: (context, index) =>
                    // ignore: prefer_const_constructors
                    Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: const Center(child: CircularProgressIndicator()),
                  // ignore: avoid_unnecessary_containers
                ),
              ),
            ),
          );
      }
    });
  }
}
