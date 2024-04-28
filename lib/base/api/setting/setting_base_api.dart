import 'dart:convert';

import 'package:qlcv/model/setting/setting_model.dart';
import 'package:qlcv/system/_base/model/content/global_model.dart';
import 'package:qlcv/system/_variables/http/store_http_model.dart';

import '../../../system/_variables/http/app_http_model.dart';
import '../../../system/user/user_data_component.dart';

class SettingBaseApi {
  Future<AppHttpModel<SettingModelDto>> getTenantByName(
      {GlobalModel? globalModel}) async {
    // ignore: prefer_collection_literals, unnecessary_new7, unnecessary_new
    var data = new Map<String, dynamic>();
    data["name"] = "App.Data.Api";
    data["tenantId"] = globalModel!.userDataModal.tenant!.id;
    data["userId"] = globalModel.userDataModal.id;

    final response = await StoreAppHttp.getData(
        // ignore: prefer_interpolation_to_compose_strings
        'services/STORE/read/Setting/GetTenantByNameForMobile',
        data,
        await UserDataComponent().getAppToken());

    var content = SettingModelDto.fromJson(
      json.decode(response.body)["result"],
    );
    if (response.statusCode == 200) {
      // ignore: unnecessary_null_comparison
      if (content != null) {
        var listValue = jsonDecode(content.value.toString());

        var listData = <SettingJson>[];

        listValue.forEach((item) {
          // ignore: unnecessary_new
          var json = new SettingJson();
          json.name = item["name"];
          json.url = item["url"];
          json.code = item["code"];
          json.entityId = item["_entityId"];
          listData.add(json);
        });

        var lisUrl = listData.where((w) => w.code!.contains("QLCV")).toList();
        content.listUrl = lisUrl;
      }

      var resuslt = AppHttpModel<SettingModelDto>(content);

      return resuslt;
    } else {
      return AppHttpModel.getError<SettingModelDto>(response.body);
    }
  }

    Future<AppHttpModel<SettingModelDto>> getTenantByGroupChat(
      {GlobalModel? globalModel}) async {
    // ignore: prefer_collection_literals, unnecessary_new7, unnecessary_new
    var data = new Map<String, dynamic>();
    data["name"] = "App.Data.Api";
    data["tenantId"] = globalModel!.userDataModal.tenant!.id;
    data["userId"] = globalModel.userDataModal.id;

    final response = await StoreAppHttp.getData(
        // ignore: prefer_interpolation_to_compose_strings
        'services/STORE/read/Setting/GetTenantByNameForMobile',
        data,
        await UserDataComponent().getAppToken());

    var content = SettingModelDto.fromJson(
      json.decode(response.body)["result"],
    );
    if (response.statusCode == 200) {
      // ignore: unnecessary_null_comparison
      if (content != null) {
        var listValue = jsonDecode(content.value.toString());

        var listData = <SettingJson>[];

        listValue.forEach((item) {
          // ignore: unnecessary_new
          var json = new SettingJson();
          json.name = item["name"];
          json.url = item["url"];
          json.code = item["code"];
          json.entityId = item["_entityId"];
          listData.add(json);
        });

        var lisUrl = listData.where((w) => w.code!.contains("KEYCHAT")).toList();
        content.listUrl = lisUrl;
      }

      var resuslt = AppHttpModel<SettingModelDto>(content);

      return resuslt;
    } else {
      return AppHttpModel.getError<SettingModelDto>(response.body);
    }
  }
}
