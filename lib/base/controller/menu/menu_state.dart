import 'package:equatable/equatable.dart';
import 'package:qlcv/system/_base/model/data/data_menu_modal_.dart';

import '../../../system/_base/model/content/bloc_status.dart';

// ignore: must_be_immutable
class MenuState extends Equatable {
  MenuState(
      {this.listMenu = const <DataMenuModal>[],
      this.status = StatusWidget.initial,
      this.hasReachedMax = false,
      this.view});

  final List<DataMenuModal> listMenu;
  String? view;
  final StatusWidget status;
  final bool hasReachedMax;

  MenuState copyWith(
      {StatusWidget? status,
      List<DataMenuModal>? listMenu,
      bool? hasReachedMax,
      String view = ""}) {
    return MenuState(
      status: status ?? this.status,
      listMenu: listMenu ?? this.listMenu,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [listMenu, hasReachedMax, view];
}
