import 'package:flutter/material.dart';

import '../model/content/global_model.dart';

// ignore: must_be_immutable
abstract class DefaultView extends StatelessWidget {
  GlobalModel? globalModel;
  // ignore: annotate_overrides, overridden_fields
  Key? key;
  Widget? layout;

  DefaultView(
    this.globalModel, {
    this.key,
    this.layout,
  }) : super(key: key);
}

class BaseController {
  GlobalModel? globalModal;
  BuildContext? context;

  BaseController(
    this.globalModal, {
    this.context,
  });
}

