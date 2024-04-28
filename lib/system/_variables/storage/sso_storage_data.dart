import 'package:qlcv/system/_variables/storage/storage_data.dart';

class SSOStorageData extends StorageData {
  static Future<void> setToken(String token) {
    return StorageData.setValue("jwt", token);
  }

  static Future<void> setCookie(String key, String cookie) {
    return StorageData.setValue(key, cookie);
  }

  static Future<String?> getToken() async {
    var token = await StorageData.getValue("jwt");

    if (token != null) {
      return SSOStorageData._formatToken(token);
    }

    return null;
  }

    static Future<String?> getTokenUser() async {
    var token = await StorageData.getValue("twt");

    if (token != null) {
      return SSOStorageData._formatToken(token);
    }

    return null;
  }


  static Future<String?> getCookie(String key) async {
    var cookie = await StorageData.getValue(key);

    if (cookie != null) {
      return SSOStorageData._formatToken(cookie);
    }

    return null;
  }

  static Future<String?> getAccessToken() async {
    return await StorageData.getValue("jwt");
  }

  static Future<void> removeToken() {
    return StorageData.deleteValue("jwt");
  }

  static Future<void> removeCookie(String key) {
    return StorageData.deleteValue(key);
  }

  static Future<dynamic> getUser() {
    return StorageData.getValue("CurrentUser");
  }

  static Future<void> setUser(dynamic user) {
    return StorageData.setValue("CurrentUser", user);
  }

    static Future<void> setTokenTime(dynamic user) {
    return StorageData.setValue("twt", user);
  }

  static Future<void> removeUser() {
    return StorageData.deleteValue("CurrentUser");
  }

  static String _formatToken(String token) {
    return "Bearer $token";
  }

  static Future<void> setEncrptedAuthToken(String encrptedAuthtoken) {
    return StorageData.setValue("enc_auth_token", encrptedAuthtoken);
  }

  static Future<String> getEncrptedAuthToken() async {
    String encrptedAuthtoken = await StorageData.getValue("enc_auth_token");
    return encrptedAuthtoken;
  }

  static Future<void> removeEncrptedAuthToken() {
    return StorageData.deleteValue("enc_auth_token");
  }
}
