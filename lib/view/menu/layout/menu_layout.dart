import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:qlcv/base/controller/menu/menu_controller.dart';
import 'package:qlcv/system/_base/view/default_view.dart';
import 'package:qlcv/system/_variables/value/app_style.dart';
import 'package:qlcv/system/_variables/value/text_app_data.dart';
import 'package:qlcv/view/user/tenant/tenant_view.dart';

import '../../../main.dart';
import '../../../system/_base/model/content/global_model.dart';
import '../../user/profile/profile_view.dart';
import '../../webview/web_view.dart';

// ignore: must_be_immutable
class MenuLayout extends DefaultView {
  // ignore: unused_field
  final GlobalModel? _globalModel;
  GlobalKey<FormState>? viewKey;
  // ignore: unused_field
  final BuildContext? _context;

  // ignore: use_key_in_widget_constructors
  MenuLayout(
      GlobalModel globalModel, GlobalKey<FormState>? key, BuildContext? context)
      : _globalModel = globalModel,
        _context = context,
        super(globalModel) {
    key = viewKey;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          // ignore: sort_child_properties_last
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 65.0,
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/logo.png'),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: const Text(
                        "QLCV",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // ignore: avoid_unnecessary_containers

                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "Email:  ${globalModel.token != null ? globalModel.userDataModal.emailAddress.toString() : _globalModel!.userDataModal.emailAddress.toString()}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15.0,
                        )),
                  ),

                  const SizedBox(
                    height: 5.0,
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Text(
                        "Name: ${globalModel.token != null ? globalModel.userDataModal.fullName.toString() : _globalModel!.userDataModal.fullName.toString()}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontSize: 14.0,
                        )),
                  )
                ],
              ),
            ],
          ),
          decoration: const BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: AssetImage("assets/menu4.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // ignore: avoid_unnecessary_containers
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 8, top: 5, bottom: 5),
          child: Row(
            children: [
              Icon(
                Icons.business,
                color: AppStyle.colors[0][5],
                size: 20,
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  globalModel.userDataModal.tenant!.name.toString(),
                  style: TextStyle(
                      color: AppStyle.colors[0][5],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1,
          height: 2,
          indent: 0,
          endIndent: 0,
          // color: Colors.white30,
        ),

        Column(
          children: buildListDataRow(context, _globalModel),
        ),
      ],
    );
  }
}

List<Widget> buildListDataRow(BuildContext context, GlobalModel? globalModel) {
  List<Widget> rows = [];

  rows.add(Column(
    children: [
      Container(
        alignment: Alignment.topLeft,
        child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.home,
                    color: Color(0xFF95D4D4),
                    size: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(TextAppData.getValue("home")),
                  )
                ],
              ),
              Container(
                alignment: Alignment.topRight,
                child: const Icon(
                  Icons.chevron_right,
                ),
              )
            ],
          ),
          onPressed: () async {
            MenuControllerCubit().gotoHome(context, globalModel!);
          },
        ),
      ),
      const Divider(
        thickness: 1,
        height: 0,
        indent: 0,
        endIndent: 0,
        // color: Colors.white30,
      ),
      Container(
        alignment: Alignment.topLeft,
        child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.business,
                    color: Color(0xFF95D4D4),
                    size: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(TextAppData.getValue("chooseTenants")),
                  )
                ],
              ),
              Container(
                alignment: Alignment.topRight,
                child: const Icon(
                  Icons.chevron_right,
                ),
              )
            ],
          ),
          onPressed: () async {
            final chat = await Navigator.of(context).push(
              TenantView.route(globalModel),
            );
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('$chat')));
          },
        ),
      ),
      const Divider(
        thickness: 1,
        height: 0,
        indent: 0,
        endIndent: 0,
        // color: Colors.white30,
      ),
    ],
  ));

  // ignore: avoid_function_literals_in_foreach_calls
  globalModel!.menus!.forEach((item) {
    rows.add(
      Container(
        alignment: Alignment.topLeft,
        child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.work,
                    color: Color(0xFF95D4D4),
                    size: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(item.name.toString()),
                  )
                ],
              ),
              Container(
                alignment: Alignment.topRight,
                child: const Icon(
                  Icons.chevron_right,
                ),
              )
            ],
          ),
          onPressed: () async {
            MenuControllerCubit().gotoTask(context, globalModel, item);
          },
        ),
      ),
    );
    rows.add(const Divider(
      thickness: 1,
      height: 0,
      indent: 0,
      endIndent: 0,
      // color: Colors.white30,
    ));
  });

  rows.add(Column(
    children: [
      Container(
        alignment: Alignment.topLeft,
        child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.message,
                    color: Color(0xFF95D4D4),
                    size: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(TextAppData.getValue("messages")),
                  )
                ],
              ),
              Container(
                alignment: Alignment.topRight,
                child: const Icon(
                  Icons.chevron_right,
                ),
              )
            ],
          ),
          onPressed: () async {
            var urlChat = globalModel.listUrl!
                .where((w) => w.code!.contains("LISTCHATQLCV"))
                // ignore: sdk_version_since
                .firstOrNull;
            Navigator.of(context).push(AppWebView.route(globalModel,
                TextAppData.getValue("groups"), urlChat!.url, "task"));
          },
        ),
      ),
      const Divider(
        thickness: 1,
        height: 0,
        indent: 0,
        endIndent: 0,
        // color: Colors.white30,
      ),
      Container(
        alignment: Alignment.topLeft,
        child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.verified_user,
                    color: Color(0xFF95D4D4),
                    size: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(TextAppData.getValue("profile")),
                  )
                ],
              ),
              Container(
                alignment: Alignment.topRight,
                child: const Icon(
                  Icons.chevron_right,
                ),
              )
            ],
          ),
          onPressed: () async {
            final profile = await Navigator.of(context).push(
              ProfileView.route(globalModel),
            );
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('$profile')));
          },
        ),
      ),
      const Divider(
        thickness: 1,
        height: 0,
        indent: 0,
        endIndent: 0,
        // color: Colors.white30,
      ),
      Container(
        alignment: Alignment.topLeft,
        child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.exit_to_app,
                    color: Color(0xFF95D4D4),
                    size: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(TextAppData.getValue("logout")),
                  )
                ],
              ),
              Container(
                alignment: Alignment.topRight,
                child: const Icon(
                  Icons.chevron_right,
                ),
              )
            ],
          ),
          onPressed: () {
            MenuControllerCubit().userLogout(context);
          },
        ),
      ),
    ],
  ));

  return rows;
}
