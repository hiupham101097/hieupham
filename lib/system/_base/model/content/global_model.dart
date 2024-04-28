import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:qlcv/system/_base/model/data/data_device_token_modal.dart';
import 'package:qlcv/system/_base/model/users/user_data_model.dart';

import '../../../../model/setting/setting_model.dart';
import '../data/data_menu_modal_.dart';

// ignore: must_be_immutable
class GlobalModel extends Equatable {
  GlobalModel.instance();

  String? token;
  late String encryptToken = "";
  late UserDataModal userDataModal;
  late bool openSetWebToken = false;
  late List<DataMenuModal>? menus;
  late List<SettingJson>? listUrl;
  late List<SettingJson>? listGroup;
  late DataDeviceTokenModal deviceToken;
  late BuildContext? currentContext;
  late int? timeLine = 0;
  late String? time;
  late String? fireBaseToken;

  Future<void> reset() async {
    this
      ..token = ""
      ..userDataModal = UserDataModal(0, "", "")
      ..deviceToken = DataDeviceTokenModal()
      ..encryptToken = ""
      ..currentContext = null
      ..openSetWebToken = false
      ..timeLine = 0
      ..time = null;
  }

  @override
  List<Object?> get props =>
      [token, encryptToken, userDataModal, fireBaseToken];
}
