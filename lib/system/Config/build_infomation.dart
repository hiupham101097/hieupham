import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qlcv/base/api/setting/setting_base_api.dart';
import 'package:qlcv/model/setting/setting_model.dart';
import 'package:qlcv/system/_base/controller/user_component.dart';
import 'package:qlcv/system/_base/model/content/global_model.dart';
import 'package:qlcv/system/_base/model/data/data_menu_modal_.dart';
import 'package:qlcv/system/_base/model/users/user_data_model.dart';
import 'package:qlcv/system/_variables/http/app_http_model.dart';
import 'package:qlcv/system/_variables/storage/fcm_storage_data.dart';
import 'package:qlcv/system/connect/components/api_device_token_component.dart';
import 'package:qlcv/system/user/user_data_component.dart';

import '../_base/model/data/data_device_token_modal.dart';

Future<void> buildUserInfomation(
    // ignore: no_leading_underscores_for_local_identifiers
    String accessToken,
    GlobalModel globalModel) async {
  BuildContext? context;
  AppHttpModel<UserDataModal>? userResult;
  AppHttpModel<List<DataMenuModal>>? userMenuResult;
  AppHttpModel<SettingModelDto>? setting;
  AppHttpModel<SettingModelDto>? settingGroup;

  int count = 0;
  while (count != -1 && count < 5) {
    try {
      // await FCMStorageData.setDeviceId(new Uuid().v4());
      userResult = await UserComponent().getCurrentUser();
      userMenuResult = await UserComponent().getUserMenus();

      // ignore: unnecessary_null_comparison
      if (userResult != null &&
          userResult.status == AppHttpModelStatus.Success &&
          userResult.value != null &&
          userResult.value!.id != 0) {
        count = -1;

        globalModel.token = accessToken;
        // ignore: unused_local_variable
        globalModel.encryptToken =
            await UserDataComponent().getEncrptedAuthToken();

        globalModel.userDataModal = userResult.value!;
        // ignore: unnecessary_new
        globalModel.deviceToken = new DataDeviceTokenModal();
        var deviceId = await FCMStorageData.getDeviceId();
        globalModel.deviceToken.deviceId = deviceId;

        globalModel.deviceToken
          ..value = globalModel.fireBaseToken!
          ..deviceId = globalModel.deviceToken.deviceId
          ..type = Platform.isIOS ? 'IOS' : 'ANDROID';

        // ignore: unnecessary_null_comparison
        if (deviceId == null || deviceId == "") {
          /// send token to server
          await ApiDeviceTokenComponent()
              .createOrUpdate(globalModel.deviceToken);
        }

        setting =
            await SettingBaseApi().getTenantByName(globalModel: globalModel);
        settingGroup = await SettingBaseApi()
            .getTenantByGroupChat(globalModel: globalModel);
        globalModel.listUrl = setting.value!.listUrl;
        globalModel.listGroup = settingGroup.value!.listUrl;
      } else {
        count = -1;

        await UserDataComponent().removeAppToken();

        if (userResult.status != AppHttpModelStatus.Success) {
          // ignore: use_build_context_synchronously
          await showDialog<String>(
            context: context!,
            builder: (BuildContext context) => AlertDialog(
              title: Text(userResult!.message!),
              content: Text(userResult.details!),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      }

      if (count != -1) {
        count++;
      }

      // ignore: unnecessary_null_comparison
      if (userMenuResult != null &&
          userMenuResult.status == AppHttpModelStatus.Success &&
          userMenuResult.value != null) {
        globalModel.menus = userMenuResult.value!;
      }
    } catch (err) {
      if (count != -1) {
        count++;
      }
    }
  }
}
