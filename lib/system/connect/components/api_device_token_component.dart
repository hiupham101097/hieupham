import 'dart:convert';

import 'package:qlcv/system/_variables/http/app_http_model.dart';
import 'package:qlcv/system/_variables/http/hub_app_http.dart';

import '../../_base/model/data/data_device_token_modal.dart';
import '../../user/user_data_component.dart';

class ApiDeviceTokenComponent {
  Future<AppHttpModel<dynamic>> createOrUpdate(
      DataDeviceTokenModal input) async {
    final response = await HubAppHttp.getData(
        'api/services/HUB/write/DeviceToken/CreateOrUpdate',
        input.toMap(),
        await UserDataComponent().getAppToken());

    if (response.statusCode == 200) {
      return AppHttpModel(json.decode(response.body)['result']);
    } else {
      return AppHttpModel.getError(response.body);
    }
  }

  Future<AppHttpModel<dynamic>> delete(DataDeviceTokenModal deviceToken) async {
    final response = await HubAppHttp.getData(
        'api/services/HUB/write/DeviceToken/Delete',
        deviceToken.toMap(),
        await UserDataComponent().getAppToken());

    if (response.statusCode == 200) {
      return AppHttpModel(json.decode(response.body)['result']);
    } else {
      return AppHttpModel.getError(response.body);
    }
  }
}
