
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/controller/login/login_cubit.dart';
import '../../main.dart';
import '../../system/_base/model/content/login_model.dart';
import 'layout/login_layout.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginView());
  }

  static Page page() => MaterialPage<void>(child: LoginView());
  final viewKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(context.read<LoginModel>()),
      child: LoginLayout(globalModel, context, viewKey),
    );
  }
}
