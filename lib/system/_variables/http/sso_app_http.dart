import 'package:http/http.dart';
import 'package:qlcv/system/_variables/http/app_http.dart';

import '../value/app_const.dart';

class SSOAppHttp extends AppHttp {
  static Future<Response> getData(
    String url,
    dynamic data,
    String? token, {
    String? sort,
  }) {
    return AppHttp.getData(AppConst.apiSSO, '/$url', data, token, sort: sort);
  }
}
