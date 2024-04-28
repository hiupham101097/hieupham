import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:qlcv/base/controller/webview/webview_event.dart';
import 'package:qlcv/base/controller/webview/webview_state.dart';

import '../../../system/_base/model/content/bloc_status.dart';
import '../../../system/_base/model/content/global_model.dart';

class WebviewBloc extends Bloc<WebviewEvent, WebviewState> {
  WebviewBloc(BuildContext? context, GlobalModel? globalModel)
      : super(WebviewState()) {
    _globalModel = globalModel;

    on<WebviewFetched>(_onWebviewFetched);
    on<WebviewModelChange>(_onGroupModalValues);
  }

  // ignore: unused_field
  GlobalModel? _globalModel;

  Future<void> _onWebviewFetched(
    WebviewFetched event,
    Emitter<WebviewState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == StatusWidget.initial) {
        var view = "";
        return emit(state.copyWith(
          status: StatusWidget.success,
          view: view,
          hasReachedMax: false,
        ));
      } else {
        var data = "";
        // ignore: unnecessary_null_comparison
        data != null
            ? emit(state.copyWith(hasReachedMax: true))
            : emit(
                state.copyWith(
                  status: StatusWidget.success,
                  view: data,
                  hasReachedMax: false,
                ),
              );
      }
    } catch (_) {
      emit(state.copyWith(status: StatusWidget.failure));
    }
  }

    Future<void> _onGroupModalValues(
    WebviewModelChange event,
    Emitter<WebviewState> emit,
  ) async {
    state.view = null;

    emit(state.copyWith(view: event.view));
  }
}
