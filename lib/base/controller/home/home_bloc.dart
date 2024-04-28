import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlcv/system/_base/model/content/bloc_status.dart';
import '../../../system/_base/model/content/global_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(BuildContext? context, GlobalModel? globalModel, String? defaultUrl)
      : super(const HomeState()) {
    _globalModel = globalModel;

    on<HomeFetched>(_onHomeFetched);
  }

  // ignore: unused_field
  GlobalModel? _globalModel;
  late Emitter<HomeState> umit;

  Future<void> _onHomeFetched(
    HomeFetched event,
    Emitter<HomeState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == StatusWidget.initial) {
        await _homeInit(emit);
      } else {
        await _homeInit(emit);
      }
    } catch (_) {
      emit(state.copyWith(status: StatusWidget.failure));
    }
  }

  Future<void> _homeInit(Emitter<HomeState> emit) async {
    return emit(state.copyWith(
      status: StatusWidget.success,
      hasReachedMax: false,
    ));
  }
}
