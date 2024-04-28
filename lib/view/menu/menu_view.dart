
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/controller/menu/menu_controller.dart';
import '../../system/_base/model/content/global_model.dart';
import 'layout/menu_layout.dart';

// ignore: must_be_immutable
class MenuView extends StatelessWidget {
  final GlobalModel? _globalModel;
  final BuildContext? _context;

  final viewKey = GlobalKey<FormState>();
  MenuView({Key? key, GlobalModel? globalModel, BuildContext? context})
      : _globalModel = globalModel,
        _context = context,
        super(key: key);

  static Page page() => MaterialPage<void>(child: MenuView());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MenuControllerCubit(),
      child: MenuLayout(_globalModel!, viewKey, _context),
    );
  }
}
