import 'package:flutter/material.dart';
import 'package:qlcv/base/controller/user/tenant/tenant_cubit.dart';
import 'package:qlcv/main.dart';
import 'package:qlcv/system/_base/model/content/global_model.dart';
import 'package:qlcv/system/_base/view/default_view.dart';
import 'package:qlcv/system/_base/view/view_scaffold_layout.dart';
import 'package:qlcv/system/_variables/value/app_style.dart';
import 'package:qlcv/system/_variables/value/text_app_data.dart';

import '../../../../system/_base/model/data/data_tenant_modal.dart';
import '../../../menu/menu_view.dart';

// ignore: must_be_immutable
class TenantLayout extends DefaultView {
  // ignore: use_key_in_widget_constructors
  TenantLayout(
      GlobalModel globalModel, GlobalKey<FormState>? key, BuildContext? context)
      : _globalModel = globalModel,
        super(globalModel) {
    key = viewKey;
  }

  final GlobalModel? _globalModel;
  GlobalKey<FormState>? viewKey;

  @override
  Widget build(BuildContext context) {
    viewContentModal.title = Text(TextAppData.getValue("chooseTenants"));
     viewContentModal.drawer = Drawer(
      child: MenuView(globalModel: globalModel),
    );
    // ignore: avoid_unnecessary_containers
    viewContentModal.body = Container(
      child: Column(
        children: _listWidgetTenant(
            context, globalModel, _globalModel!.userDataModal.listTenant),
      ),
    );
    return ViewScaffoldLayout(
      globalModel: _globalModel,
    );
  }
}

List<Widget> _listWidgetTenant(BuildContext context, GlobalModel globalModel,
    List<DataTenantModal>? listTenant) {
  List<Widget> listD = [];
  var controller = TenantCubit(globalModel, context);

  for (var item in listTenant!) {
    listD.add(Container(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        color: AppStyle.colors[0][4],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child:  CircleAvatar(
                            backgroundColor: AppStyle.colors[1][0],
                            child:  Icon(
                              Icons.home,
                              color: AppStyle.colors[2][0],
                              size: 17.0,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(item.name, style: TextStyle(color: AppStyle.colors[1][0]),),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      Icons.chevron_right,
                      color: AppStyle.colors[1][7],
                      size: 17,
                    ),
                  )
                ],
              ),
              onPressed: () {
                controller.joinTenant(context, item.id, item.tenancyName);
              },
            )
          ],
        ),
      ),
    ));
  }

  return listD;
}
