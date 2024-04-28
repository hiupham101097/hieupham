import 'package:object_mapper/object_mapper.dart';

import '../../../_variables/value/app_const.dart';

class DataDeviceTokenModal with Mappable {
  /// DeviceId
  late String deviceId;

  /// ClientTokens
  late String value;

  String application = AppConst.QLCV_HUB;
  String? type;

  DataDeviceTokenModal({
    this.deviceId = "",
    this.value = "",
    this.type = "",
    this.application = AppConst.QLCV_HUB,
  });

  @override
  void mapping(Mapper map) {
    map("key", deviceId, (v) => deviceId = v);
    map("value", value, (v) => value = v);
    map("application", application, (v) => application = v);
    map("type", type, (v) => type = v);
  }

  factory DataDeviceTokenModal.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return DataDeviceTokenModal();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<DataDeviceTokenModal>();
    return obj ?? DataDeviceTokenModal();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }
}
