
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/controller/user/profile/profile_bloc.dart';
import '../../../base/controller/user/profile/profile_event.dart';
import '../../../system/_base/model/content/global_model.dart';
import 'layouts/profile_layout.dart';

class ProfileView extends StatelessWidget {
  ProfileView({
    Key? key,
    GlobalModel? globalModel,
  })  : _globalModel = globalModel,
        super(key: key);
  static Route route(GlobalModel? globalModal) {
    return MaterialPageRoute<void>(
        builder: (_) => ProfileView(
              globalModel: globalModal,
            ));
  }

  final GlobalModel? _globalModel;
  final viewKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(context, _globalModel)..add(ProfileFetched()),
      child: ProfileLayout(_globalModel, viewKey),
    );
  }
}
