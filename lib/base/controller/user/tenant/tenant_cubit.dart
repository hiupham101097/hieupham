import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlcv/system/_base/model/content/global_model.dart';
import 'package:qlcv/system/_base/model/content/token_model.dart';
import 'package:qlcv/system/_variables/http/app_http_model.dart';
import 'package:qlcv/view/home/home_view.dart';
import 'package:uuid/uuid.dart';
import '../../../../main.dart';
import '../../../../system/_base/controller/user_component.dart';
import '../../../../system/_variables/http/qlcv_app_http.dart';
import '../../../../system/_variables/storage/fcm_storage_data.dart';
import '../../../../system/user/user_data_component.dart';

class TenantCubit extends Cubit<GlobalModel> {
  TenantCubit(GlobalModel globalModel, BuildContext initialState)
      : super(globalModel) {
    // ignore: unnecessary_new

  }

  Future<void> joinTenant(
      BuildContext context, int tenantId, String tenantName) async {
    globalModel.reset();

    var tokenResult = await UserComponent().joinTenant(tenantId, tenantName);
    if (tokenResult.status == AppHttpModelStatus.Success) {
      globalModel.openSetWebToken = true;
      globalModel.encryptToken = tokenResult.value!.encryptedAccessToken!;

      await buildAppInfomation(tokenResult.value!);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeView(
                  globalModel: globalModel,
                )),
      );
    } else {
      // ignore: use_build_context_synchronously
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(tokenResult.message!),
          content: Text(tokenResult.details!),
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

  Future<void> buildAppInfomation(TokenModel token) async {
    await UserDataComponent().setAppToken(token.accessToken);

    await UserDataComponent().setEncrptedAuthToken(token.encryptedAccessToken!);

    /// set deviceId
    // ignore: prefer_const_constructors, unnecessary_new
    await FCMStorageData.setDeviceId(new Uuid().v4());
    var userLogin = await UserComponent().getCurrentUser();
    var menus = await UserComponent().getUserMenus();

    // ignore: unnecessary_null_comparison
    if (userLogin != null &&
        userLogin.status == AppHttpModelStatus.Success &&
        userLogin.value != null &&
        userLogin.value!.id != 0) {
      globalModel.token = token.accessToken;
      globalModel.encryptToken =
          await UserDataComponent().getEncrptedAuthToken();
      var accessTokenData =
          'accessToken=${Uri.encodeComponent(globalModel.token!.replaceAll("Bearer", "").trim())}&encryptedAccessToken=${Uri.encodeComponent(globalModel.encryptToken)}';
      QlcvAppHttp.qlcvUrl("/web-view/setToken3?$accessTokenData");
      if (menus.value != null) {
        globalModel.menus = menus.value;
      }

      globalModel.userDataModal = userLogin.value!;
    }
  }
}
