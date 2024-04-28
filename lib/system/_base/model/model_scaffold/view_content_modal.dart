// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';

enum ViewStatus { View, Edit, ViewSecurity }

class ViewContentModal extends ChangeNotifier {
  ViewContentModal.instance();
  Widget? currentWidget;

  Widget? _title;
  Widget? get title => _title;
  set title(Widget? value) {
    if (true) {
      _title = value;
    }
  }

  Widget? _drawer;
  Widget? get drawer => _drawer;
  set drawer(Widget? value) {
    if (true) {
      _drawer = value;
    }
  }

  List<Widget>? _actions;
  List<Widget>? get actions => _actions;
  set actions(List<Widget>? value) {
    if (true) {
      _actions = value;
    }
  }

  ViewStatus _status = ViewStatus.View;
  ViewStatus get status => _status;
  set status(ViewStatus value) {
    if (true) {
      _status = value;
    }
  }

  Widget? _body;
  Widget? get body => _body;
  set body(Widget? value) {
    if (true) {
      _body = value;
    }
  }

  Widget? _notify;
  Widget? get notify => _notify;
  set notify(Widget? value) {
    if (true) {
      _notify = value;
    }
  }

  ViewContentModal changeValues({
    Widget? body,
    ViewStatus viewStatus = ViewStatus.View,
    Widget? title,
    Widget? drawer,
    List<Widget>? actions,
    Widget? notify,
    bool isNotify = true,
    bool isViewNotifyIcon = true,
    bool isViewLoadding = false,
  }) {
    _body = body ?? _body;
    _status = viewStatus;
    _title = title ?? _title;
    _drawer = drawer ?? _drawer;
    _actions = actions ?? _actions;
    _notify = isViewNotifyIcon == true ? notify ?? _notify : null;

    // ignore: unrelated_type_equality_checks
    if (notify == true) {
      notifyListeners();
    }

    return this;
  }
}
