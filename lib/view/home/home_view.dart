// ignore: must_be_immutableimport 'package:flutter/material.dart'
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/controller/home/home_bloc.dart';
import '../../base/controller/home/home_event.dart';
import '../../system/_base/model/content/global_model.dart';
import 'layouts/home_layout.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({Key? key, GlobalModel? globalModel})
      : _globalModel = globalModel,
        super(key: key);
  static Route route(GlobalModel? globalModal) {
    return MaterialPageRoute<void>(
        builder: (_) => HomeView(
              globalModel: globalModal,
            ));
  }

  static Page page(GlobalModel? globalModal) => MaterialPage<void>(
          child: HomeView(
        globalModel: globalModal,
      ));

  final GlobalModel? _globalModel;
  final viewKey = GlobalKey<FormState>();
  String? defaultUrls;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomeBloc(context, _globalModel, defaultUrls)..add(HomeFetched()),
      child: HomeLayout(_globalModel, viewKey),
    );
  }
}
