import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlcv/system/_base/model/content/global_model.dart';
import 'package:qlcv/view/webview/web_view.dart';

import '../../../main.dart';
import '../../../system/_base/model/data/data_menu_modal_.dart';
import '../../../system/_variables/storage/fcm_storage_data.dart';
import '../../../system/connect/components/api_device_token_component.dart';
import '../../../system/user/user_data_component.dart';
import '../../../view/home/home_view.dart';
import '../../../view/login/login_view.dart';

class MenuControllerCubit extends Cubit {
  MenuControllerCubit() : super(null);

  Future<void> logout() async {
    await UserDataComponent().removeAppToken();
    globalModel.reset();
    // Navigator.pushReplacementNamed(
    //   context,
    //   '/',
    // );
  }

  void userLogout(BuildContext context) async {
    ApiDeviceTokenComponent().delete(globalModel.deviceToken);

    /// remove store data on your phone
    await FCMStorageData.removeToken();
    await FCMStorageData.removeDeviceId();
    await UserDataComponent().removeAppToken();

    globalModel.reset();


    // ignore: use_build_context_synchronously
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  void gotoHome(BuildContext context, GlobalModel globalModel) async {
    final home = await Navigator.of(context).push(
      HomeView.route(globalModel),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$home')));
  }

  void gotoTask(BuildContext context, GlobalModel globalModel,
      DataMenuModal? input) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AppWebView(
                globalModel: globalModel,
                url: input!.valueData!,
                title: input.name,
                checkChat: "task",
              )),
    );
  }

  void goToTenants(BuildContext context, GlobalModel globalModel) async {
    final home = await Navigator.of(context).push(
      HomeView.route(globalModel),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$home')));
  }
}
