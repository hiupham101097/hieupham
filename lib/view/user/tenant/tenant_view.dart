import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlcv/base/controller/user/tenant/tenant_cubit.dart';
import '../../../system/_base/model/content/global_model.dart';
import 'layouts/tenant_layout.dart';

class TenantView extends StatelessWidget {
  TenantView({
    Key? key,
    GlobalModel? globalModel,
  })  : _globalModel = globalModel,
        super(key: key);
  static Route route(GlobalModel? globalModal) {
    return MaterialPageRoute<void>(
        builder: (_) => TenantView(
              globalModel: globalModal,
            ));
  }

  final GlobalModel? _globalModel;
  final viewKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TenantCubit(_globalModel!, context),
      child: TenantLayout(_globalModel!, viewKey, context),
    );
  }
}
