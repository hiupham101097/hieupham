import 'package:flutter/material.dart';
import 'package:qlcv/system/_base/model/content/global_model.dart';
import 'package:qlcv/system/_variables/value/app_style.dart';
import '../../../main.dart';
import '../../_variables/value/text_app_data.dart';

class ViewScaffoldLayout extends StatelessWidget {
  const ViewScaffoldLayout(
      {Key? key, GlobalModel? globalModel, Widget? title, Widget? body})
      : _globalModel = globalModel,
        _title = title,
        _body = body,
        super(key: key);

  // ignore: unused_field
  final GlobalModel? _globalModel;
  // ignore: unused_field
  final Widget? _title;
  // ignore: unused_field
  final Widget? _body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.colors[1][0],
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppStyle.colors[0][4],
        title: title(context),
        actions: actions(context),
        
      ),
      drawer: drawer(context) ,
      body: content(context),
      resizeToAvoidBottomInset: true,
    );
  }

  Widget title(BuildContext context) {
    final viewScaffoldModal = viewContentModal;

    return viewScaffoldModal.title ?? Text(TextAppData.getValue('title'));
  }

  Widget? content(BuildContext context) {
    final viewScaffoldModal = viewContentModal;

    return viewScaffoldModal.body;
  }

    Widget? drawer(BuildContext context) {
    final viewScaffoldModal = viewContentModal;
    return viewScaffoldModal.drawer;
  }

  List<Widget>? actions(BuildContext context) {
     final viewScaffoldModal = viewContentModal;

    if (viewScaffoldModal.actions == null) {
      return viewScaffoldModal.notify == null
          ? []
          : [viewScaffoldModal.notify!];
    }
    if (viewScaffoldModal.notify == null) {
      return viewScaffoldModal.actions;
    }

    List<Widget> list = [];
    list.addAll(viewScaffoldModal.actions!);
    list.add(viewScaffoldModal.notify!);

    return list;
  }
}
