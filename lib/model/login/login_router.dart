import 'package:flutter/material.dart';

import '../../main.dart';
import '../../system/_base/model/content/bloc_status.dart';
import '../../view/home/home_view.dart';
import '../../view/login/login_view.dart';

List<Page> onGenerateAppViewPages(BlocStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case BlocStatus.authenticated:
      return [HomeView.page(globalModel)];
    case BlocStatus.unauthenticated:
      return [LoginView.page()];
    case BlocStatus.unknown:
      return [];
  }
}
