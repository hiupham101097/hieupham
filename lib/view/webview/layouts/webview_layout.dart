// ignore_for_file: deprecated_member_use, unnecessary_brace_in_string_interps
import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qlcv/base/controller/webview/webview_event.dart';
import 'package:qlcv/system/_variables/value/app_style.dart';
import 'package:qlcv/view/menu/menu_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../base/controller/webview/webview_bloc.dart';
import '../../../base/controller/webview/webview_state.dart';
import '../../../system/_base/model/content/bloc_status.dart';
import '../../../system/_base/model/content/file_data_model.dart';
import '../../../system/_base/model/content/global_model.dart';
import '../../../system/_variables/value/text_app_data.dart';

// ignore: must_be_immutable
class AppWebViewLayout extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  AppWebViewLayout(GlobalModel globalModel, GlobalKey<FormState>? key,
      this.title, this.url, String? isCheck)
      : _globalModel = globalModel,
        checkChat = isCheck,
        super() {
    key = viewKey;
  }

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() =>
      // ignore: no_logic_in_create_state
      _AppWebViewLayout(_globalModel, url, title, checkChat);

  // ignore: prefer_final_fields
  GlobalModel? _globalModel;
  GlobalKey<FormState>? viewKey;
  String? title;
  String? url;
  String? checkChat;
}

// ignore: unused_element
class _AppWebViewLayout extends State<AppWebViewLayout> {
  _AppWebViewLayout(this.globalModel, this.url, this.title, this.checkChat);

  GlobalModel? globalModel;
  String? title;
  String? url;
  double length = 0;
  bool isCheck = false;
  String? checkChat;
  bool? isChat;

  var files = <File>[];
  var listFile = <FileDataModal>[];

  final GlobalKey webViewKey = GlobalKey();
  // ignore: prefer_final_fields
  late TextEditingController _txtChat = TextEditingController();

  double progress = 0;
  final urlController = TextEditingController();
  Timer? _timer;
  int? _progress = 0;
  // ignore: unnecessary_nullable_for_final_variable_declarations
  final int? _totalActionTimeInSeconds = 3;
  dynamic ctrl;
  bool? checkData;
  bool? checkTask;
  final ReceivePort _port = ReceivePort();

  //WebViewController? dataWebviewController;
  InAppWebViewController? webViewController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
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

  @override
  void initState() {
    super.initState();
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _txtChat.addListener(() {
      isCheck = _txtChat.text.isNotEmpty;
      // ignore: unnecessary_this
      setState(() => this.isCheck = isCheck);

      context.read<WebviewBloc>().add(WebviewModelChange("V"));
    });
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');

    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      // ignore: avoid_print
      print("Download progress: $progress%");

      if (status == DownloadTaskStatus.complete) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Download $id completed!"),
        ));
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  var userAgent = Platform.isIOS == true
      ? 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.1 Mobile/15E148 Safari/604.1'
      : 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

  void _initCounter() {
    _timer?.cancel();
    _progress = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() => _progress = _progress! + 100);

      if (Duration(milliseconds: _progress!).inSeconds >=
          _totalActionTimeInSeconds!) {
        _timer!.cancel();
        // Do something
      }
    });
  }

  void _stopCounter() {
    _timer?.cancel();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    setState(() => _progress = 0);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _txtChat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Future<bool> _willPopCallback(String? url) async {
      bool canNavigate = await webViewController!.canGoBack();
      if (canNavigate) {
        webViewController!.goBack();
        setState(() {
          if (checkChat == "chat") {
            checkChat = "task";
          } else if (isChat == true) {
            checkChat = "chat";
            isChat = false;
          }
        });
        return false;
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        return true;
      }
    }

    // ignore: unused_local_variable
    var userAgent = Platform.isIOS == true
        ? 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.1 Mobile/15E148 Safari/604.1'
        : 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 150.0) {
      length = 150.0;
    } else if (screenWidth < 150.0 && screenWidth < 350.0) {
      length = 180.0;
    } else if (screenWidth > 350.0 && screenWidth < 500.0) {
      length = 280.0;
    } else if (screenWidth > 500.0 && screenWidth < 1000.0) {
      length = 600.0;
    } else if (screenWidth > 1000.0 && screenWidth < 1500.0) {
      length = 700.0;
    } else {
      length = 150.0;
    }

    var authToken = Uri.encodeComponent(
        globalModel!.token!.replaceAll("Bearer", "").trim());
    // ignore: unused_local_variable
    var tenant = globalModel!.userDataModal.tenant!.id;
    var encAuthToken = Uri.encodeComponent(globalModel!.encryptToken.trim());
    return BlocBuilder<WebviewBloc, WebviewState>(
      builder: (context, state) {
        switch (state.status) {
          case StatusWidget.failure:
            return Scaffold(
              appBar: AppBar(
                elevation: 1,
                backgroundColor: AppStyle.colors[0][4],
                title: const Center(child: CircularProgressIndicator()),
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
              onWillPop: () => _willPopCallback(url),
              child: Scaffold(
                key: _key,
                appBar: AppBar(
                  backgroundColor: AppStyle.colors[0][4],
                  titleSpacing: 0.0,
                  elevation: 5.0,
                  leading: IconButton(
                      onPressed: () => _willPopCallback(url),
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppStyle.colors[1][0],
                      )),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                          onPressed: () => _key.currentState!.openDrawer(),
                          icon: Icon(
                            Icons.menu,
                            color: AppStyle.colors[1][0],
                          )),
                      const SizedBox(
                        width: 15,
                      ),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        //margin: EdgeInsets.fromLTRB(0, 0, 130, 0),
                        child: checkChat == 'chat'
                            ? Text(TextAppData.getValue("messages"))
                            : Text(title.toString()),
                      )
                    ],
                  ),
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
                            initialOptions: options,
                            initialUrlRequest: URLRequest(url: Uri.parse(url!)),
                            // initialOptions: options,
                            onWebViewCreated: (controller) async {
                              webViewController = controller;

                              final prefs =
                                  await SharedPreferences.getInstance();
                              // ignore: unused_local_variable
                              var value = prefs.getString(
                                "SETTOKEN",
                              );
                              controller.addJavaScriptHandler(
                                handlerName: 'mobileListener',
                                callback: (args) async {
                                  // ignore: avoid_print
                                  print(args);
                                  // ignore: unused_local_variable
                                  var isCheck = false;
                                  if (args.isNotEmpty) {
                                    if (args[0] == "SETCOOKIE") {
                                      isCheck = true;
                                    }
                                    if (args[0] == 'sendTask') {
                                      checkChat = "task";
                                      title = "Công việc";
                                      context
                                          .read<WebviewBloc>()
                                          .add(WebviewModelChange("V"));
                                    }
                                    if (args[0] == 'sendMess') {
                                      checkChat = "chat";
                                      isChat = true;
                                      context
                                          .read<WebviewBloc>()
                                          .add(WebviewModelChange("V"));
                                    }
                                  }

                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString("SETTOKEN", "false");
                                },
                              );
                            },
                            onLoadStop: ((controller, url) async {
                              final prefs =
                                  await SharedPreferences.getInstance();
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
                              var url = downloadStartRequest.url.toString();

                              var hasStoragePermission =
                                  await Permission.storage.isGranted;
                              if (!hasStoragePermission) {
                                final status =
                                    await Permission.storage.request();
                                hasStoragePermission = status.isGranted;
                              }
                              await FlutterDownloader.enqueue(
                                url: url,
                                savedDir:
                                    (await getExternalStorageDirectory())!.path,
                                showNotification:
                                    true, // show download progress in status bar (for Android)
                                openFileFromNotification:
                                    true, // click on notification to open downloaded file (for Android)
                                saveInPublicStorage: true,
                              );
                            },
                          ),
                        ],
                      )),
                      checkChat == "chat"
                          ? GestureDetector(
                              onTapDown: (_) => _initCounter(),
                              onTapUp: (_) => _stopCounter(),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                decoration: BoxDecoration(
                                    color: AppStyle.colors[1][0],
                                    border: Border.all(
                                        color: AppStyle.colors[1][6])),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              primary: Colors.white,
                                              backgroundColor:
                                                  AppStyle.colors[1][4],
                                              onSurface: Colors.grey,
                                              minimumSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      14,
                                                  10)),
                                          onPressed: () {
                                            webViewController!
                                                .evaluateJavascript(
                                              source: 'openModalFile()',
                                            );
                                          },
                                          child: Icon(
                                            Icons.file_upload,
                                            size: 13,
                                            color: AppStyle.colors[1][7],
                                          ),
                                        ),
                                        Container(
                                            width: length,
                                            padding: const EdgeInsets.all(5),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (_txtChat.text != "") {
                                                    isCheck = true;
                                                  } else {
                                                    isCheck = false;
                                                  }
                                                  context
                                                      .read<WebviewBloc>()
                                                      .add(WebviewModelChange(
                                                          "V"));
                                                });
                                              },
                                              child: TextFormField(
                                                controller: _txtChat,
                                                focusNode: FocusNode(),
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(0.0),
                                                  border: InputBorder.none,
                                                  hintText:
                                                      "Nhập nội dung tin nhắn",
                                                  hintStyle:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                scrollPadding:
                                                    const EdgeInsets.all(10),
                                                style: const TextStyle(
                                                    fontSize: 15),
                                                maxLines: 9999,
                                                minLines: 1,
                                                keyboardType:
                                                    TextInputType.multiline,
                                              ),
                                            ))
                                      ],
                                    ),
                                    _txtChat.text == ""
                                        ? TextButton(
                                            style: TextButton.styleFrom(
                                                primary: Colors.white,
                                                backgroundColor:
                                                    AppStyle.colors[2][0],
                                                onSurface: Colors.grey,
                                                minimumSize: Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        10,
                                                    10)),
                                            onPressed: () {
                                              webViewController!
                                                  .evaluateJavascript(
                                                      source:
                                                          'sendLikeEvent()');
                                              // dataWebviewController!
                                              //     .evaluateJavascript(
                                              //         'sendLikeEvent()');
                                            },
                                            child: const Icon(
                                              Icons.thumb_up_alt_outlined,
                                              size: 13,
                                            ),
                                          )
                                        : TextButton(
                                            style: TextButton.styleFrom(
                                                primary: Colors.white,
                                                backgroundColor:
                                                    AppStyle.colors[2][0],
                                                onSurface: Colors.grey,
                                                minimumSize: Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        10,
                                                    10)),
                                            onPressed: () {
                                              webViewController!.evaluateJavascript(
                                                  source:
                                                      'sendEvent("${_txtChat.text}")');
                                              // dataWebviewController!
                                              //     .evaluateJavascript(
                                              //         'sendEvent("${_txtChat.text}")');
                                              _txtChat.text = "";
                                            },
                                            child: const Icon(
                                              Icons.send,
                                              size: 13,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : Container()
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
                  title.toString(),
                ),
              ),
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
      },
    );
  }
}
