import 'dart:convert';

import '../../_variables/http/app_http_model.dart';
import '../../_variables/http/sso_app_http.dart';
import '../../user/user_data_component.dart';
import '../model/content/criteria_value.dart';
import '../model/data/data_menu_modal_.dart';
import '../model/content/global_model.dart';
import '../model/content/login_model.dart';
import '../model/content/token_model.dart';
import '../model/users/user_data_model.dart';

class UserComponent {
  UserComponent();

  Future<AppHttpModel<TokenModel>> userLogin(
    LoginModel data,
  ) async {
    final response = await SSOAppHttp.getData(
      'api/TokenAuth/Authenticate',
      data.toMap(),
      null,
    );

    if (response.statusCode == 200) {
      return AppHttpModel<TokenModel>(
        TokenModel.fromJson(
          json.decode(response.body)["result"],
        ),
      );
    } else {
      return AppHttpModel.getError<TokenModel>(response.body);
    }
  }

  Future<AppHttpModel<bool>> saveCurrenProfile(Map input) async {
    final response = await SSOAppHttp.getData(
      'api/services/sso/write/User/UpdateInfo',
      input,
      await UserDataComponent().getAppToken(),
    );

    if (response.statusCode == 200) {
      return AppHttpModel<bool>(
        true,
      );
    } else {
      return AppHttpModel.getError<bool>(response.body);
    }
  }

  Future<AppHttpModel<bool>> changeAccount(Map input) async {
    final response = await SSOAppHttp.getData(
      'api/services/sso/write/User/ChangeAccount',
      input,
      await UserDataComponent().getAppToken(),
    );

    if (response.statusCode == 200) {
      return AppHttpModel<bool>(
        true,
      );
    } else {
      return AppHttpModel.getError<bool>(response.body);
    }
  }

  Future<AppHttpModel<TokenModel>> joinTenant(int tenantId, String name) async {
    // ignore: prefer_collection_literals, unnecessary_new
    var data = new Map<String, dynamic>();
    data["id"] = tenantId;
    data["name"] = name;

    final response = await SSOAppHttp.getData(
      'api/TokenAuth/joinTenant',
      data,
      await UserDataComponent().getAppToken(),
    );

    if (response.statusCode == 200) {
      return AppHttpModel<TokenModel>(
        TokenModel.fromJson(
          json.decode(response.body)["result"],
        ),
      );
    } else {
      return AppHttpModel.getError<TokenModel>(response.body);
    }
  }

  Future<AppHttpModel<List<UserDataModal?>>> getByListUserId(
      List<int?> listUserId, GlobalModel inputGlobal) async {
    final response = await SSOAppHttp.getData(
        'api/services/sso/read/User/GetByListUserId',
        listUserId,
        await UserDataComponent().getAppToken());

    var content = json.decode(response.body)['result'];

    content.forEach((item) {
      item["isEmailConfirmed"] = true;
    });

    if (response.statusCode == 200) {
      List<UserDataModal?> items =
          (content as Iterable).map((e) => UserDataModal.fromJson(e)).toList();

      return AppHttpModel<List<UserDataModal?>>(items);
    } else {
      return AppHttpModel.getError<List<UserDataModal?>>(response.body);
    }
  }

  Future<AppHttpModel<UserDataModal>> getCurrentUser() async {
    final response = await SSOAppHttp.getData(
      'api/services/sso/read/User/GetCurrentUser',
      null,
      await UserDataComponent().getAppToken(),
    );

    if (response.statusCode == 200) {
      var result = AppHttpModel<UserDataModal>(
        UserDataModal.fromJson(
          json.decode(response.body)["result"],
        ),
      );
      return result;
    } else {
      return AppHttpModel.getError<UserDataModal>(response.body);
    }
  }

  Future<AppHttpModel<List<DataMenuModal>>> getUserMenus() async {
    // ignore: unnecessary_new
    var getMenuModal = new DataGetModal(
      criterias: [
        DataCriteriaModal(
          propertyName: "groupCode",
          operation: "Contains",
          value: "QLCV",
        ),
      ],
    );

    final response = await SSOAppHttp.getData(
      'api/services/sso/read/Menu/GetList',
      getMenuModal.toMap(),
      await UserDataComponent().getAppToken(),
    );

    var content = json.decode(response.body);

    if (response.statusCode == 200) {
      List<DataMenuModal> items = (content['result'] as Iterable)
          .map((e) => DataMenuModal.fromJson(e))
          .toList();

      return AppHttpModel<List<DataMenuModal>>(items);
    } else {
      return AppHttpModel.getError<List<DataMenuModal>>(response.body);
    }
  }
}
