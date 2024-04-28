import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../system/_base/model/content/bloc_status.dart';
import '../../../system/_base/model/content/global_model.dart';
import '../../../system/_base/model/users/user_data_model.dart';

part 'main_event.dart';
part 'main_state.dart';

// ignore: duplicate_ignore
class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({required GlobalModel globalModel})
      : _globalModel = globalModel,
        super(
          globalModel.encryptToken != "" || globalModel.token != null
              ? const MainState.authenticated()
              : const MainState.unauthenticated(),
        ) {
    on<MainStatusChanged>(_onMainStatusChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
  }

  final GlobalModel _globalModel;

  void _onLogoutRequested(AppLogoutRequested event, Emitter<MainState> emit) {
    unawaited(_globalModel.reset());
  }

  void _onMainStatusChanged(
    MainStatusChanged event,
    Emitter<MainState> emit,
  ) async {
    switch (event.status) {
      case BlocStatus.unauthenticated:
        return emit(const MainState.unauthenticated());
      case BlocStatus.authenticated:
        return emit(const MainState.authenticated());
      default:
        return emit(const MainState.unknown());
    }
  }

  // ignore: unnecessary_overrides,
}
