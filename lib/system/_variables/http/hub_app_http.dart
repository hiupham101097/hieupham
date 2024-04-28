import 'package:http/http.dart';

import '../value/app_const.dart';
import 'app_http.dart';

class HubAppHttp extends AppHttp {
  static String hubUrl(String url) {
    return AppConst.urlQLCV + url;
  }

  static Future<Response> getData(
    String url,
    dynamic data,
    String? token, {
    String? sort,
    Map<String, dynamic>? queryParams,
  }) {
    return AppHttp.getData(
      AppConst.apiHUB,
      '/api-hub/$url',
      data,
      token,
      sort: sort,
      queryParams: queryParams,
    );
  }
}
