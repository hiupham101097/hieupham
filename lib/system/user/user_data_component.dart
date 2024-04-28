

import '../_variables/storage/sso_storage_data.dart';

class UserDataComponent {
  UserDataComponent();

  Future<String?> getAppToken() {
    return SSOStorageData.getToken();
  }

    Future<String?> getAppTokenUser() {
    return SSOStorageData.getTokenUser();
  }

  Future<void> setAppToken(String token) {
    return SSOStorageData.setToken(token);
  }

    Future<void> setAppTokenUser(String token) {
    return SSOStorageData.setTokenTime(token);
  }

  Future<void> removeAppToken() {
    return SSOStorageData.removeToken();
  }

  Future<String> getEncrptedAuthToken() {
    return SSOStorageData.getEncrptedAuthToken();
  }

  Future<void> setEncrptedAuthToken(String encrptedAuthtoken) {
    return SSOStorageData.setEncrptedAuthToken(encrptedAuthtoken);
  }
}
