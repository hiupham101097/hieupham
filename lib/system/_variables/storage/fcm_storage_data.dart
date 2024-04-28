
import 'package:qlcv/system/_variables/storage/storage_data.dart';

class FCMStorageData extends StorageData {
  /// Notifications
  static Future<bool> getNotificationFlag() async {
    final temp = await StorageData.getValue("NotificationFlag");
    return temp != null ? true : false;
  }

  static Future<void> enableNotificationFlag() {
    return StorageData.setValue("NotificationFlag", true);
  }

  static Future<void> disableNotificationFlag() {
    return StorageData.setValue("NotificationFlag", false);
  }

  /// Token firebase
  static Future<String> getToken() async {
    var token = await StorageData.getValue("Token");
    return token != null ? token.toString() : "";
  }

    static Future<String> getCookie() async {
    var cookie = await StorageData.getValue("Cookie");
    return cookie != null ? cookie.toString() : "";
  }

  static Future<void> removeToken() {
    return StorageData.deleteValue("Token");
  }

  /// DeviceId UUID
  static Future<String> getDeviceId() async {
    var deviceId = await StorageData.getValue("DeviceId");
    return deviceId != null ? deviceId.toString() : "";
  }

  static Future<void> setDeviceId(String deviceId) {
    return StorageData.setValue("DeviceId", deviceId);
  }

  static Future<void> removeDeviceId() {
    return StorageData.deleteValue("DeviceId");
  }
}
