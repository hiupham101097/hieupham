import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlcv/base/controller/menu/menu_state.dart';
import 'package:qlcv/system/_base/controller/user_component.dart';
import 'package:qlcv/system/_base/model/content/bloc_status.dart';
import '../../../system/_base/model/content/global_model.dart';

import 'menu_event.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc(BuildContext? context, GlobalModel? globalModel)
      : super(MenuState()) {
    _globalModel = globalModel;

    on<MenuFetched>(_onMenuFetched);
  }

  // ignore: unused_field
  GlobalModel? _globalModel;

  Future<void> _onMenuFetched(
    MenuFetched event,
    Emitter<MenuState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == StatusWidget.initial) {
        await _menuInit(emit);
      } else {
        await _menuInit(emit);
      }
    } catch (_) {
      emit(state.copyWith(status: StatusWidget.failure));
    }
  }

  Future<void> _menuInit(Emitter<MenuState> emit) async {
    var result = await UserComponent().getUserMenus();

    return emit(state.copyWith(
      status: StatusWidget.success,
      listMenu: result.value,
      hasReachedMax: false,
    ));
  }
}
