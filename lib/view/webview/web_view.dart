import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlcv/base/controller/webview/webview_bloc.dart';
import 'package:qlcv/view/webview/layouts/webview_layout.dart';
import '../../system/_base/model/content/global_model.dart';
import '../../base/controller/webview/webview_event.dart';

// ignore: must_be_immutable
class AppWebView extends StatelessWidget {
  AppWebView({
    Key? key,
    GlobalModel? globalModel,
    this.title,
    this.url = "",
    this.checkChat,
    // this.showClose = true,
    // this.addViewWidget,
    // this.redirectWidget,
  })  : _globalModel = globalModel,
        super(key: key);
  static Route route(
      GlobalModel? globalModal, String? title, String? url, String? isCheck) {
    return MaterialPageRoute<void>(
        builder: (_) => AppWebView(
            globalModel: globalModal,
            title: title,
            url: url!,
            checkChat: isCheck));
  }

  final GlobalModel? _globalModel;
  final viewKey = GlobalKey<FormState>();
  String? title;
  String url;
  String? checkChat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WebviewBloc(context, _globalModel)..add(WebviewFetched()),
      child: AppWebViewLayout(_globalModel!, viewKey, title, url, checkChat),
    );
  }
}
